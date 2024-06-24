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
        case .signup, .login, .writePost, .writeReply, .writeGameRecord:
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
        case .writeGameRecord:
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
        case .login(let parameters), .signup(let parameters), .writePost(let parameters), .writeReply(let parameters), .writeGameRecord(let parameters), .updatePost(_, let parameters), .updateReply(_, let parameters), .updateTeam(_, let parameters), .getPosts(let parameters), .getPost(_, let parameters), .getReplies(let parameters):
            return parameters
        case .updateViewCount, .getTeams, .getUser, .deletePost, .deleteReply, .getGameRecords, .getGameRecord, .deleteGameRecord:
            return Parameters()
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
        default:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
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

}
