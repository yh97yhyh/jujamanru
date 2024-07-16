//
//  NetworkManager.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation
import Alamofire
import Combine

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}

enum APIRouter: URLRequestConvertible {
    case login(Parameters)
    case signup(Parameters)
    case writePost(Parameters)
    case writeReply(Parameters)
    case writeGameRecord(Parameters)
    case writeGameRecordWithImages(parameters: Parameters, images: [UIImage])
    
    case updateViewCount(postId: Int)
    case updatePost(postId: Int, parameters: Parameters)
    case updateReply(replyId: Int, parameters: Parameters)
    case updateTeam(userId: String, parameters: Parameters)
    
    case getPosts(parameters: Parameters)
    case getPost(postId: Int, parameters: Parameters)
    case getTeams
    case getReplies(parameters: Parameters)
    case getUser(userId: String)
    case getGameRecords(userId: String)
    case getGameRecord(gameRecordId: Int)
    
    case deletePost(postId: Int)
    case deleteReply(replyId: Int)
    case deleteGameRecord(gameRecordId: Int)
    
    var method: HTTPMethod {
        switch self {
        case .signup, .login, .writePost, .writeReply, .writeGameRecord, .writeGameRecordWithImages:
            return .post
        case .getPosts, .getPost, .getTeams, .getReplies, .getUser, .getGameRecords, .getGameRecord:
            return .get
        case .updateViewCount, .updatePost, .updateReply, .updateTeam:
            return .put
        case .deletePost, .deleteReply, .deleteGameRecord:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .signup:
            return "/auth/signup"
        case .writePost:
            return "/posts"
        case .writeReply:
            return "/replies"
        case .writeGameRecord, .writeGameRecordWithImages:
            return "/game-records"
        case .updateViewCount(let postId):
            return "/posts/\(postId)/view-count"
        case .updatePost(let postId, _):
            return "/posts/\(postId)"
        case .updateReply(let replyId, _):
            return "/replies/\(replyId)"
        case .updateTeam(let userId, _):
            return "/users/\(userId)/team"
        case .getPosts:
            return "/posts"
        case .getPost(let postId, _):
            return "/posts/\(postId)"
        case .getTeams:
            return "/teams"
        case .getReplies:
            return "/replies"
        case .getUser(let userId):
            return "/users/\(userId)"
        case .getGameRecords(let userId):
            return "/game-records/list/\(userId)"
        case .getGameRecord(let gameRecordId):
            return "/game-records/\(gameRecordId)"
        case .deletePost(let postId):
            return "/posts/\(postId)"
        case .deleteReply(let replyId):
            return "/replies/\(replyId)"
        case .deleteGameRecord(let gameRecordId):
            return "/game-records/\(gameRecordId)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let parameters), .signup(let parameters), .writePost(let parameters), .writeReply(let parameters), .writeGameRecord(let parameters), .writeGameRecordWithImages(let parameters, _), .updatePost(_, let parameters), .updateReply(_, let parameters), .updateTeam(_, let parameters), .getPosts(let parameters), .getPost(_, let parameters), .getReplies(let parameters):
            return parameters
        case .updateViewCount, .getTeams, .getUser, .deletePost, .deleteReply, .getGameRecords, .getGameRecord, .deleteGameRecord:
            return Parameters()
        }
    }
    
    var images: [UIImage]? {
        switch self {
        case .writeGameRecordWithImages(_, let images):
            return images
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try API.baseUrlString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch method {
        case .get:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//        default:
//            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
//        }
        default:
            if let images = images {
                // Do not set Content-Type here for multipart/form-data
            } else {
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            }
        }
        
        return urlRequest
    }
}

final class NetworkManager<T: Codable> {
    static func request(route: APIRouter) -> AnyPublisher<T, NetworkError> {
        return AF.request(route)
            .validate()
            .publishDecodable(type: T.self)
            .tryMap { response -> T in
                guard let value = response.value else {
                    throw NetworkError.error(err: "Decoding error")
                }
                return value
            }
            .mapError { error -> NetworkError in
                if let statusCode = (error.asAFError?.responseCode) {
                    switch statusCode {
                    case 401:
                        return .error(err: "Unauthorized")
                    default:
                        return .error(err: "Status code: \(statusCode)")
                    }
                } else {
                    return .error(err: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func requestWithoutResponse(route: APIRouter) -> AnyPublisher<Int, Never> {
        return AF.request(route)
            .validate()
            .publishData()
            .map { _ in return 1 }
            .replaceError(with: 0)
            .eraseToAnyPublisher()
    }
    
    static func requestFormData(route: APIRouter) -> AnyPublisher<T, NetworkError> {
        return Future<T, NetworkError> { promise in
            AF.upload(multipartFormData: { multipartFormData in
                if let parameters = route.parameters {
                    for (key, value) in parameters {
                        if let data = try? JSONSerialization.data(withJSONObject: value, options: []) {
                            multipartFormData.append(data, withName: key, mimeType: "application/json")
                        }
                    }
                }
                if let images = route.images {
                    for image in images {
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            multipartFormData.append(imageData, withName: "images", fileName: "image.jpg", mimeType: "image/jpeg")
                        }
                    }
                }
            }, with: route)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 401:
                            promise(.failure(.error(err: "Unauthorized")))
                        default:
                            promise(.failure(.error(err: "Status code: \(statusCode)")))
                        }
                    } else {
                        promise(.failure(.error(err: error.localizedDescription)))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}
