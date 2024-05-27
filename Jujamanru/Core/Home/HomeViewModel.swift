//
//  HomeViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/25/24.
//

import Foundation
import Alamofire

class HomeViewModel: ObservableObject {
    @Published var popularPosts: [Post]
    @Published var myTeamPopularPosts: [Post]
    @Published var notices: [Post]
    
    init(_ popularPosts: [Post] = [], _ myTeamPopularPosts: [Post] = [], _ notices: [Post] = [], myTeamId: Int? = nil) {
        self.popularPosts = popularPosts
        self.myTeamPopularPosts = myTeamPopularPosts
        self.notices = notices
        
        fetchPopularPosts()
        fetchMyTeamPopularPosts(myTeamId)
        fetchNotices()
    }
    
    func fetchPopularPosts() {
        let parameters: Parameters = [
                "isPopular": true
            ]
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters)) { result in
            switch result {
            case .success(let postsResponse):
                self.popularPosts = postsResponse.content
                print("succeed to get popular posts!")
            case .failure(let error):
                print("failed to get popular posts.. \(error.localizedDescription)")
            }
        }
//        NetworkManager<PostsResponse>.callGet(urlString: "/posts", parameters: parameters) { result in
//            switch result {
//            case .success(let postsResponse):
//                self.popularPosts = postsResponse.content
//                print("succeed to get popular posts!")
//            case .failure(let error):
//                print("failed to get popular posts.. \(error.localizedDescription)")
//            }
//        }
    }
    
    func fetchMyTeamPopularPosts(_ myTeamId: Int?) {
        if myTeamId == nil {
            return
        }
        
        let parameters: Parameters = [
                "isPopular": true,
                "teamId": myTeamId!
            ]
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters)) { result in
            switch result {
            case .success(let postsResponse):
                self.myTeamPopularPosts = postsResponse.content
                print("succeed to get my team popular posts!")
            case .failure(let error):
                print("failed to get my ream popular posts.. \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNotices() {
        let parameters: Parameters = [
                "isNotice": true
            ]
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters)) { result in
            switch result {
            case .success(let postsResponse):
                self.notices = postsResponse.content
                print("succeed to get notices!")
            case .failure(let error):
                print("failed to get notices.. \(error.localizedDescription)")
            }
        }
    }
}
