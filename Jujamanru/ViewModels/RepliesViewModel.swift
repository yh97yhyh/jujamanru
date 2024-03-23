//
//  RepliesViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation
import Alamofire

class RepliesViewModel: ObservableObject {
    
    @Published var replies: [Reply]
    @Published var postId: Int
    
    @Published var isCanAddReplies = true
    @Published var totalCount = 0
    
    private var fetchCount = 0
    private var page = 1
    private var totalPages = 0
    
    @Published var isFetching = true

    init(_ replies: [Reply] = Reply.MOCK_REPLIES_POST1, postId: Int) {
        self.replies = replies
        self.postId = postId
        
        fetchReplies(postId)
    }
    
    func fetchReplies(_ postId: Int) {
        let parameters: Parameters = [
                "postId": postId
            ]
        
        NetworkManager<RepliesResponse>.callGet(urlString: "/replies", parameters: parameters) { result in
            switch result {
            case .success(let repliesResponse):
                self.replies = repliesResponse.content
                self.totalPages = repliesResponse.totalPages
                self.totalCount = repliesResponse.totalElements
                print("succeed to get replies!")
            case .failure(let error):
                print("failed to get replies.. \(error.localizedDescription)")
            }
        }
    }
    
    func addReplies(_ postId: Int) {
        if !isCanAddReplies {
            return
        }
        
        let parameters: Parameters = [
                "postId": postId
            ]
        
        NetworkManager<RepliesResponse>.callGet(urlString: "/replies", parameters: parameters) { result in
            switch result {
            case .success(let postsResponse):
                self.isCanAddReplies = !postsResponse.last
                self.replies += postsResponse.content
                print("succeed to add replies \(self.page)page!")
                self.page += 1
            case .failure(let error):
                print("failed to add replies \(self.page)page.. \(error.localizedDescription)")
            }
        }
    }
    
}
