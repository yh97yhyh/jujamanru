//
//  PostViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation
import Alamofire
import Combine

class PostViewModel: ObservableObject {
    @Published var post: Post
    @Published var datetime: String
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ post: Post = Post.MOCK_POSTS[0], postId: Int, userId: String) {
        self.post = post
        self.datetime = post.timeView
        
        fetchPost(postId, userId)
//        addViewCount()
    }
    
    func fetchPost(_ postId: Int, _ userId: String) {
        let parameters: Parameters = [
                "userId": userId
            ]
        
        NetworkManager<Post>.request(route: .getPost(postId: postId, parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] post in
                self?.post = post
                self?.datetime = post.timeView
            }
            .store(in: &cancellables)
}
