//
//  MyPageViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation
import Alamofire
import Combine

class MyPageViewModel: ObservableObject {
//    static let shared = MyPageViewModel()
    
    @Published var user: User
    @Published var myTeam: Team?
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
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ user: User, _ posts: [Post] = [], _ replies: [Reply] = [], _ scraps: [Post] = []) {
        self.user = user
        self.posts = posts.filter  { $0.createdBy == user.id }
        self.replies = replies.filter { $0.createdBy == user.id }
        self.scraps = scraps
        
        fetchMyPosts()
        fetchMyReplies()
        fetchMyTeamImage()
    }
    
    func fetchMyTeam() {
        NetworkManager<User>.request(route: .getUser(userId: user.id))
            .sink { _ in
                
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.myTeam = user.team
                AuthManager.shared.saveuser(user)
            }.store(in: &cancellables)
    }
    
    func updateTeam(_ teamId: Int) {
        let parameters: Parameters = [
            "teamId": teamId
        ]
        
        NetworkManager<Int>.request(route: .updateTeam(userId: user.id, parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] teamId in
                self?.fetchMyTeam()
            }.store(in: &cancellables)
    }
    
    func fetchMyPosts() {
        let parameters: Parameters = [
            "userId": user.id
        ]
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] postsResponse in
                self?.posts = postsResponse.content
                self?.isCanAddPosts = !postsResponse.last
                self?.totalPostPages = postsResponse.totalPages
                self?.totalPostsCount = postsResponse.totalElements
            }.store(in: &cancellables)
    }
    
    func addPosts() {
        if !isCanAddPosts {
            return
        }
        
        let parameters: Parameters = [
            "userId": user.id,
            "page": postsPage
        ]
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] postsResponse in
                self?.isCanAddPosts = !postsResponse.last
                self?.posts += postsResponse.content
                self?.postsPage += 1
            }.store(in: &cancellables)
    }
    
    func fetchMyReplies() {
        let parameters: Parameters = [
                "userId": user.id
            ]
        
        NetworkManager<RepliesResponse>.request(route: .getReplies(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] repliesResponse in
                self?.replies = repliesResponse.content
                self?.totalRepliesPages = repliesResponse.totalPages
                self?.totalRepliesCount = repliesResponse.totalElements
            }.store(in: &cancellables)
    }
    
    func addReplies(_ postId: Int) {
        if !isCanAddReplies {
            return
        }
        
        let parameters: Parameters = [
                "page": repliesPage,
                "postId": postId
            ]
        
        NetworkManager<RepliesResponse>.request(route: .getReplies(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] postsResponse in
                self?.isCanAddReplies = !postsResponse.last
                self?.replies += postsResponse.content
                self?.repliesPage += 1
            }.store(in: &cancellables)
        
    }
    
    func fetchMyTeamImage() -> String? {
        guard let myTeam = myTeam else {
            return nil
        }
        
        switch myTeam.id {
        case 1: return "lg-twins-logo.png"
        case 2: return "ky-wiz-logo.png"
        case 3: return "ssg-landers-logo.png"
        case 4: return "nc-dinos-logo.png"
        case 5: return "doosan-bears-logo.png"
        case 6: return "kia-tigers-logo.png"
        case 7: return "lotte-giants-logo.png"
        case 8: return "samsung-lions-logo.png"
        case 9: return "hanwha-eagles-logo.png"
        case 10: return "kiwoom-heros-logo.png"
        default: return nil
        }
    }
}
