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
    
    func writeReply() {
        let parameters: Parameters = [
            "postId": postId,
            "userId": userId,
            "text": text
        ]
        NetworkManager<Int>.callPost(urlString: "/replies", parameters: parameters) { result in
            switch result {
            case .success(let replyId):
                print("succeed to write reply! \(replyId)!")
            case .failure(let error):
                print("failed to write reply.. \(error.localizedDescription)")
            }
        }
    }
}
