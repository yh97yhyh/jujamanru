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
    @Published var userProfileImage: String?
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
        fetchTeamImage(user.team?.id)
    }
    
    func fetchMyTeam() {
        NetworkManager<User>.request(route: .getUser(userId: user.id))
            .sink { _ in
                
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.myTeam = user.team
                self?.fetchTeamImage(user.team?.id)
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
    
    func fetchTeamImage(_ teamId: Int?) {
        guard let teamId = teamId else {
            return
        }
        
        switch teamId {
        case 1: userProfileImage = "ssg-landers-logo"
        case 2: userProfileImage = "kia-tigers-logo"
        case 3: userProfileImage = "doosan-bears-logo"
        case 4: userProfileImage = "lotte-giants-logo"
        case 5: userProfileImage = "samsung-lions-logo"
        case 6: userProfileImage = "nc-dinos-logo"
        case 7: userProfileImage = "lg-twins-logo"
        case 8: userProfileImage = "kt-wiz-logo"
        case 9: userProfileImage = "kiwoom-heroes-logo"
        case 10: userProfileImage = "hanwha-eagles-logo"
        default: userProfileImage = nil
        }
    }
}
