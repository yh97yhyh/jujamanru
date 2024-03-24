//
//  NetworkManager.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation
import Alamofire

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


enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}

