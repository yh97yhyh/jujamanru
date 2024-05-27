//
//  PostDetailViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/25/24.
//

import Foundation
import Alamofire

class PostDetailViewModel: ObservableObject {
    @Published var post: Post
    @Published var datetime: String
    
    init(_ post: Post = Post.MOCK_POSTS[0], postId: Int, userId: String) {
        self.post = post
        self.datetime = post.timeView
        
        fetchPost(postId, userId, isAddCount: true)
    }
    
    func fetchPost(_ postId: Int, _ userId: String, isAddCount: Bool) {
        let parameters: Parameters = [
                "userId": userId
            ]
        NetworkManager<Post>.request(route: .getPost(postId: postId, parameters: parameters)) { result in
            switch result {
            case .success(let post):
                self.post = post
                self.datetime = post.timeView
                if post.createdBy != userId && isAddCount {
                    self.addViewCount()
                }
                print("succeed to get post!")
            case .failure(let error):
                print("failed to get post.. \(error.localizedDescription)")
            }
        }
    }
    
    func deletePost(completion: @escaping (Int) -> Void) {
        NetworkManager<Int>.requestWithoutResponse(route: .deletePost(postId: post.id)) { result in
            completion(result)
        }
    }
    
    func addViewCount() {
        print("postId : \(post.id)")
        
        DispatchQueue.global().async {
            NetworkManager<Int>.requestWithoutResponse(route: .updateViewCount(postId: self.post.id)) { result in
                switch result {
                case 1:
                    print("succeed to update view count!")
                case 2:
                    print("failed to update view count..")
                default:
                    print("failed to update view count..")
                }
            }
        }
    }
    
}
