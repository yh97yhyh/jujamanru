//
//  PostViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation
import Alamofire

class PostViewModel: ObservableObject {
    @Published var post: Post
//    @Published var replies: [Reply]
    @Published var datetime: String
    
    init(_ post: Post = Post.MOCK_POSTS[0], postId: Int, userId: String) {
        self.post = post
//        self.replies = replies.filter { $0.postId == post.id }
        self.datetime = post.timeView
        
        fetchPost(postId, userId)
    }
    
    func fetchPost(_ postId: Int, _ userId: String) {
        let parameters: Parameters = [
                "userId": userId
            ]
        NetworkManager<Post>.callGet(urlString: "/posts/\(postId)", parameters: parameters) { result in
            switch result {
            case .success(let post):
                self.post = post
                self.datetime = post.timeView
//                self.replies = post.replies ?? []
//                print("succeed to get post!")
            case .failure(let error):
                print("failed to get post.. \(error.localizedDescription)")
            }
        }
    }
    
}
