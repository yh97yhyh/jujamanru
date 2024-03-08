//
//  PostViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var post: Post
    @Published var replies: [Reply]
    
    init(_ post: Post = Post.MOCK_POSTS[0], replies: [Reply] = Reply.MOCK_REPLIES) {
        self.post = post
        self.replies = replies.filter { $0.postId == post.id }
    }
}
