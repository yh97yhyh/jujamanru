//
//  ReplyEditViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/26/24.
//

import Foundation
import Alamofire
import Combine

class ReplyEditViewModel: ObservableObject {
    @Published var reply: Reply
    @Published var text: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ reply: Reply) {
        self.reply = reply
        self.text = reply.text
    }
    
    func editReply(completion: @escaping (Result<Int, NetworkError>) -> Void) {
        let parameters: Parameters = [
            "postId": reply.postId,
            "userId": reply.createdBy,
            "text": text
        ]
        
        NetworkManager<Int>.request(route: .updateReply(replyId: reply.id, parameters: parameters))
            .sink { _ in
                
            } receiveValue: { _ in
                
            }.store(in: &cancellables)
    }
}
