//
//  ReplyEditViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/26/24.
//

import Foundation
import Alamofire

class ReplyEditViewModel: ObservableObject {
    @Published var reply: Reply
    @Published var text: String = ""
    
    init(_ reply: Reply) {
        self.reply = reply
        self.text = reply.text
//        print(reply)
    }
    
    func editReply(completion: @escaping (Result<Int, NetworkError>) -> Void) {
        let parameters: Parameters = [
            "postId": reply.postId,
            "userId": reply.createdBy,
            "text": text
        ]
        
        NetworkManager<Int>.callPut(urlString: "/replies/\(reply.id)", parameters: parameters) { result in
            completion(result)
        }
    }
}
