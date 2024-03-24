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
    
    init(_ user: User = User.MOCK_USER_SSG, _ posts: [Post] = Post.MOCK_POSTS, _ replies: [Reply] = Reply.MOCK_REPLIES, _ scraps: [Post] = []) {
        self.user = user
//        self.myTeam = user.team
        self.posts = posts.filter  { $0.createdBy == user.id }
        self.replies = replies.filter { $0.createdBy == user.id }
        self.scraps = scraps
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
        
    }
}
