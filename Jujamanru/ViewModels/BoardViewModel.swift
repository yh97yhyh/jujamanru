//
//  CategoryViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

class BoardViewModel: ObservableObject {
    static let shared = BoardViewModel()
    
    @Published var teams: [Team]
    @Published var posts: [Post]
    @Published var notices: [Notice]
    
    init(_ teams: [Team] = Team.TEAMS, _ posts: [Post] = Post.MOCK_POSTS, _ notices: [Notice] = Notice.MOCK_NOTCIES) {
        self.teams = teams
        self.posts = posts
        self.notices = notices
    }
    
}
