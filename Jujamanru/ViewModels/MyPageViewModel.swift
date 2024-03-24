//
//  MyPageViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation
import Alamofire

class MyPageViewModel: ObservableObject {
    static let shared = MyPageViewModel()
    
    @Published var user: User
//    @Published var myTeam: Team?
    @Published var posts: [Post]
    @Published var replies: [Reply]
    @Published var scraps: [Post]
    
    @Published var isCanAddPosts = true
    @Published var totalPostsCount = 0
    private var fetchPostsCount = 0
    private var postsPage = 1
    private var totalPostPages = 0
    
    @Published var isCanAddReplies = true
    @Published var totalRepliesCount = 0
    private var fetchRepliesCount = 0
    private var repliesPage = 1
    private var totalRepliesPages = 0
    
    init(_ user: User = User.MOCK_USER_SSG, _ posts: [Post] = Post.MOCK_POSTS, _ replies: [Reply] = Reply.MOCK_REPLIES, _ scraps: [Post] = []) {
        self.user = user
        self.posts = posts.filter  { $0.createdBy == user.id }
        self.replies = replies.filter { $0.createdBy == user.id }
        self.scraps = scraps
        
        fetchMyPosts()
        fetchMyReplies()
    }
    
    func updateTeam(_ teamId: Int) {
        let parameters: Parameters = [
            "teamId": teamId
        ]
        NetworkManager<Int>.callPut(urlString: "/users/\(user.id)/team", parameters: parameters) { result in
            switch result {
            case .success(let teamId):
                print("succeed to update team! \(teamId)")
            case .failure(let error):
                print("failed to update team.. \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMyPosts() {
        let parameters: Parameters = [
            "userId": user.id
        ]
        
        NetworkManager<PostsResponse>.callGet(urlString: "/posts", parameters: parameters) { result in
            switch result {
            case .success(let postsResponse):
                self.posts = postsResponse.content
                self.isCanAddPosts = !postsResponse.last
                self.totalPostPages = postsResponse.totalPages
                self.totalPostsCount = postsResponse.totalElements
                print("succeed to get posts!")
            case .failure(let error):
                print("failed to get posts.. \(error.localizedDescription)")
            }
        }
    }
    
    func addPosts() {
        if !isCanAddPosts {
            return
        }
        
        let parameters: Parameters = [
            "userId": user.id,
            "page": postsPage
        ]
        
        NetworkManager<PostsResponse>.callGet(urlString: "/posts", parameters: parameters) { result in
            switch result {
            case .success(let postsResponse):
                self.isCanAddPosts = !postsResponse.last
                self.posts += postsResponse.content
                print("succeed to add posts \(self.postsPage)page!")
                self.postsPage += 1
            case .failure(let error):
                print("failed to add posts \(self.postsPage)page.. \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMyReplies() {
        let parameters: Parameters = [
                "userId": user.id
            ]
        
        NetworkManager<RepliesResponse>.callGet(urlString: "/replies", parameters: parameters) { result in
            switch result {
            case .success(let repliesResponse):
                self.replies = repliesResponse.content
                self.totalRepliesPages = repliesResponse.totalPages
                self.totalRepliesCount = repliesResponse.totalElements
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
                "page": repliesPage,
                "postId": postId
            ]
        
        NetworkManager<RepliesResponse>.callGet(urlString: "/replies", parameters: parameters) { result in
            switch result {
            case .success(let postsResponse):
                self.isCanAddReplies = !postsResponse.last
                self.replies += postsResponse.content
                print("succeed to add replies \(self.repliesPage)page!")
                self.repliesPage += 1
            case .failure(let error):
                print("failed to add replies \(self.repliesPage)page.. \(error.localizedDescription)")
            }
        }
    }
}
