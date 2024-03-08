//
//  PostViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var post: Post
    
    init(_ post: Post = Post.MOCK_POSTS[0]) {
        self.post = post
    }
}
