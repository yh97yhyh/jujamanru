//
//  CategoryViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation
import Alamofire
import Combine

class BoardViewModel: ObservableObject {
    static let shared = BoardViewModel()
    
    @Published var selectedTeam = 0 {
        didSet {
            fetchPosts()
        }
    }
    @Published var posts: [Post]
    @Published var notices: [Post]
//    @Published var newPostsCount: Int = 0
    
    @Published var isCanAddPosts = true
    @Published var totalCount = 0
    
    private var fetchCount = 0
    private var page = 1
    private var totalPages = 0
    @Published var isFetching = true
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ teams: [Team] = [], _ posts: [Post] = [], _ notices: [Post] = []) {
//        self.teams = teams
        self.posts = posts
        self.notices = notices
        
        fetchPosts()
    }
    
    func fetchPosts() {
        page = 1
        isCanAddPosts = true
        
        var parameters = Parameters()
        if selectedTeam != 0 {
            parameters = [
                "teamId": selectedTeam
            ]
        }
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] postsResponse in
                self?.posts = postsResponse.content
                self?.isCanAddPosts = !postsResponse.last
                self?.notices = postsResponse.content.filter { $0.isNotice == true }
                self?.totalPages = postsResponse.totalPages
                self?.totalCount = postsResponse.totalElements
            }
            .store(in: &cancellables)

    }
    
    func addPosts() {
        if !isCanAddPosts {
            return
        }
        
        var parameters = Parameters()
        if selectedTeam != 0 {
            parameters  = [
                "page": page,
                "teamId": selectedTeam
            ]
        } else {
            parameters = [
                "page": page
            ]
        }
        
        NetworkManager<PostsResponse>.request(route: .getPosts(parameters: parameters))
            .sink { _ in
                
            } receiveValue: { [weak self] postsResponse in
                self?.isCanAddPosts = !postsResponse.last
                self?.posts += postsResponse.content
                self?.page += 1
            }
            .store(in: &cancellables)
    }
    
    func toggleFetch() {
        self.fetchCount += 1
        if self.fetchCount >= 1 {
            self.isFetching = false
            self.fetchCount = 0
        }
    }
}
