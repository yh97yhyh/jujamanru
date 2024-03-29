//
//  ReplyViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import Foundation

class ReplyViewModel: ObservableObject {
    @Published var reply: Reply
    @Published var datetime: String

    init(_ reply: Reply = Reply.MOCK_REPLIES[0]) {
        self.reply = reply
        self.datetime = reply.timeView
    }
    
    func deleteReply(completion: @escaping (Int) -> Void) {
        NetworkManager<Int>.callDeleteWithoutResponse(urlString: "/replies/\(reply.id)") { result in
            completion(result)
        }
    }
}
