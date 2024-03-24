//
//  ReplyWriteViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation
import Alamofire

class ReplyWriteViewModel: ObservableObject {
    @Published var postId: Int
    @Published var userId: String
    
    @Published var text: String = ""
    
    init(postId: Int, userId: String) {
        self.postId = postId
        self.userId = userId
    }
    
    func writeReply(completion: @escaping (Result<Int, NetworkError>) -> Void) {
        let parameters: Parameters = [
            "postId": postId,
            "userId": userId,
            "text": text
        ]
        NetworkManager<Int>.callPost(urlString: "/replies", parameters: parameters) { result in
            completion(result)
        }
    }
}
