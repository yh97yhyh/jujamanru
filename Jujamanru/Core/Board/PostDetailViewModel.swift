//
//  PostDetailViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/25/24.
//

import Foundation
import Alamofire
import Combine

class PostDetailViewModel: ObservableObject {
    @Published var post: Post
    @Published var datetime: String
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ post: Post = Post.MOCK_POSTS[0], postId: Int, userId: String) {
        self.post = post
        self.datetime = post.timeView
        
        fetchPost(postId, userId, isAddCount: true)
    }
    
    func fetchPost(_ postId: Int, _ userId: String, isAddCount: Bool) {
        let parameters: Parameters = [
                "userId": userId
            ]
        
        NetworkManager<Post>.request(route: .getPost(postId: postId, parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] post in
                self?.post = post
                self?.datetime = post.timeView
                if post.createdBy != userId && isAddCount {
                    self?.addViewCount()
                }
            }.store(in: &cancellables)
    }
    
    func deletePost(completion: @escaping (Int) -> Void) {
        NetworkManager<Int>.requestWithoutResponse(route: .deletePost(postId: post.id))
            .sink { _ in
                
            } receiveValue: { _ in
                
            }.store(in: &cancellables)
    }
    
    func addViewCount() {
        print("postId : \(post.id)")
        
        DispatchQueue.global().async {
            NetworkManager<Int>.requestWithoutResponse(route: .updateViewCount(postId: self.post.id))
                .sink { _ in
                    
                } receiveValue: { _ in
                    
                }.store(in: &self.cancellables)
        }
    }
    
}
