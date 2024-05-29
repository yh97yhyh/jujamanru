//
//  ReplyViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import Foundation
import Combine

class ReplyViewModel: ObservableObject {
    @Published var reply: Reply
    @Published var datetime: String
    
    var cancellables = Set<AnyCancellable>()

    init(_ reply: Reply = Reply.MOCK_REPLIES[0]) {
        self.reply = reply
        self.datetime = reply.timeView
    }
    
    func deleteReply(completion: @escaping (Int) -> Void) {
        NetworkManager<Int>.requestWithoutResponse(route: .deleteReply(replyId: reply.id))
            .sink { _ in
                
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
}
