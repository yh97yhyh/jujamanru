//
//  RepliesViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation
import Alamofire
import Combine

class RepliesViewModel: ObservableObject {
    
    @Published var replies: [Reply]
    @Published var postId: Int
    
    @Published var isCanAddReplies = true
    @Published var totalCount = 0
    
    private var fetchCount = 0
    private var page = 1
    private var totalPages = 0
    @Published var isFetching = true
    
    var cancellables = Set<AnyCancellable>()

    init(_ replies: [Reply] = [], postId: Int) {
        self.replies = replies
        self.postId = postId
        
        fetchReplies(postId)
    }
    
    func fetchReplies(_ postId: Int) {
        page = 1
        isCanAddReplies = true
        
        let parameters: Parameters = [
                "postId": postId
            ]
        
        NetworkManager<RepliesResponse>.request(route: .getReplies(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] repliesResponse in
                self?.replies = repliesResponse.content
                self?.totalPages = repliesResponse.totalPages
                self?.totalCount = repliesResponse.totalElements
            }
            .store(in: &cancellables)
    }
    
    func addReplies(_ postId: Int) {
        if !isCanAddReplies {
            return
        }
        
        let parameters: Parameters = [
                "page": page,
                "postId": postId
            ]
        
        NetworkManager<RepliesResponse>.request(route: .getReplies(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] repliesResponse in
                self?.isCanAddReplies = !repliesResponse.last
                self?.replies += repliesResponse.content
                self?.page += 1
            }
            .store(in: &cancellables)
    }
    
}
