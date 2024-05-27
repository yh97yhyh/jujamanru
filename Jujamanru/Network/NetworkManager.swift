//
//  NetworkManager.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}

enum APIRouter: URLRequestConvertible {
    case post(String, Parameters)
    case get(String, Parameters)
    case put(String, Parameters)
    case putWithoutResponse(String)
    case delete(String, Parameters)
    case deleteWithoutResponse(String)
    
    var method: HTTPMethod {
            switch self {
            case .post:
                return .post
            case .get:
                return .get
            case .put, .putWithoutResponse:
                return .put
            case .delete, .deleteWithoutResponse:
                return .delete
            }
        }
    
    var path: String {
        switch self {
        case .post(let urlString, _),
                .get(let urlString, _),
                .put(let urlString, _),
                .putWithoutResponse(let urlString),
                .delete(let urlString, _),
                .deleteWithoutResponse(let urlString):
            return urlString
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .post(_, let parameters),
                .get(_, let parameters),
                .put(_, let parameters),
                .delete(_, let parameters):
            return parameters
        case .putWithoutResponse,
                .deleteWithoutResponse:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try API.baseUrlString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
        case .get:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}

final class NetworkManager<T: Codable> {
    
    static func callPost(urlString: String, parameters: Parameters, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = URL(string: API.baseUrlString + urlString)!
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(.invalidData))
                        return
                    }
                    
                    do {
                        let json = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(json))
                    } catch let err {
                        print(String(describing: err))
                        completion(.failure(.decodingError(err: err.localizedDescription)))
                    }
                    
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 401 {
                            completion(.failure(.error(err: "Unauthorized")))
                        } else {
                            completion(.failure(.error(err: "Status code: \(statusCode)")))
                        }
                    } else {
                        completion(.failure(.error(err: error.localizedDescription)))
                    }
                }
            }
    }
    
    static func callGet(urlString: String, parameters: Parameters = Parameters(), completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = URL(string: API.baseUrlString + urlString)!

        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(.invalidData))
                        return
                    }
                    
                    do {
                        let json = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(json))
                    } catch let err {
                        print(String(describing: err))
                        completion(.failure(.decodingError(err: err.localizedDescription)))
                    }
                    
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 401 {
                            completion(.failure(.error(err: "Unauthorized")))
                        } else {
                            completion(.failure(.error(err: "Status code: \(statusCode)")))
                        }
                    } else {
                        completion(.failure(.error(err: error.localizedDescription)))
                    }
                }
            }
    }
    
    static func callPut(urlString: String, parameters: Parameters = Parameters(), completion: @escaping (Result<T, NetworkError>) -> Void) {
        let url = URL(string: API.baseUrlString + urlString)!
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(.invalidData))
                        return
                    }
                    
                    do {
                        let json = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(json))
                    } catch let err {
                        print(String(describing: err))
                        completion(.failure(.decodingError(err: err.localizedDescription)))
                    }
                    
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 401 {
                            completion(.failure(.error(err: "Unauthorized")))
                        } else {
                            completion(.failure(.error(err: "Status code: \(statusCode)")))
                        }
                    } else {
                        completion(.failure(.error(err: error.localizedDescription)))
                    }
                }
            }
    }
    
    static func callPutWithoutResponse(urlString: String, completion: @escaping (Int) -> Void) {
        let url = URL(string: API.baseUrlString + urlString)!
        
        AF.request(url, method: .put, parameters: Parameters(), encoding: JSONEncoding.default)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(1)
                    
                case .failure(let error):
                    completion(0)
                }
            }
    }
    
    static func callDeleteWithoutResponse(urlString: String, completion: @escaping (Int) -> Void) {
        let url = URL(string: API.baseUrlString + urlString)!
        
        AF.request(url, method: .delete, parameters: Parameters(), encoding: JSONEncoding.default)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(1)
                    
                case .failure(let error):
                    completion(0)
                }
            }
    }
    
    static func callDelete(urlString: String, parameters: Parameters = Parameters(), completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let url = URL(string: API.baseUrlString + urlString)!
        
        AF.request(url, method: .delete, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 401 {
                            completion(.failure(.error(err: "Unauthorized")))
                        } else {
                            completion(.failure(.error(err: "Status code: \(statusCode)")))
                        }
                    } else {
                        completion(.failure(.error(err: error.localizedDescription)))
                    }
                }
            }
    }
}
