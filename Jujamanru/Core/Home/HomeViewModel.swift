//
//  HomeViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/25/24.
//

import Foundation
import Alamofire
import Combine

class HomeViewModel: ObservableObject {
    @Published var popularPosts: [Post]
    @Published var myTeamPopularPosts: [Post]
    @Published var notices: [Post]
    
    var cancellables = Set<AnyCancellable>()
    
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
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] postsResponse in
                self?.popularPosts = postsResponse.content
            }.store(in: &cancellables)
    }
    
    func fetchMyTeamPopularPosts(_ myTeamId: Int?) {
        if myTeamId == nil {
            return
        }
        
        let parameters: Parameters = [
                "isPopular": true,
                "teamId": myTeamId!
            ]
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] postsResponse  in
                self?.myTeamPopularPosts = postsResponse.content
            }.store(in: &cancellables)
    }
    
    func fetchNotices() {
        let parameters: Parameters = [
                "isNotice": true
            ]
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] postsResponse in
                self?.notices = postsResponse.content
            }.store(in: &cancellables)
    }
}
