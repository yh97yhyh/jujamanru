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
//    @Published var newPostsCount: Int = 0
    
    init(_ teams: [Team] = Team.TEAMS, _ posts: [Post] = Post.MOCK_POSTS, _ notices: [Notice] = Notice.MOCK_NOTCIES) {
        self.teams = teams
        self.posts = posts
        self.notices = notices
//        updateNewPostsCount()
    }
    
//    private func updateNewPostsCount() {
//        let currentDate = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let todayDateString = dateFormatter.string(from: currentDate)
//        
//        newPostsCount = posts.filter {
//            $0.createdDatetime.starts(with: todayDateString)
//        }.count
//    }
    
}
