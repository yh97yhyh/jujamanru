//
//  PostsView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct PostsView: View {
    @StateObject var viewModel = BoardViewModel.shared
    @Binding var selectedTeam: Int
    @State var isSeeNotice = true
    
    private var filteredPosts: [Post] {
        if selectedTeam == 0 {
            return viewModel.posts.sorted(by: { $0.createdDatetime > $1.createdDatetime })
        } else {
            return viewModel.posts
                .filter { $0.teamId == selectedTeam }
                .sorted(by: { $0.createdDatetime > $1.createdDatetime })
        }
    }
    
    private var newPostsCount: Int {
        filteredPosts.filter { post in
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let todayDateString = dateFormatter.string(from: currentDate)
            return post.createdDatetime.starts(with: todayDateString)
        }.count
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("새글 \(newPostsCount) / \(filteredPosts.count)")
                    .font(.subheadline)
                Spacer()
                Button("공지보기") {
                    isSeeNotice.toggle()
                }
                .buttonStyle(FilterButtonStyle())
                .font(.subheadline)
            }
            .padding(.horizontal)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                if isSeeNotice {
                    
                }
                
                ForEach(filteredPosts, id: \.self) { post in
                    NavigationLink(destination: PostDetailView(viewModel: PostViewModel(post))) {
                        PostCellView(viewModel: PostViewModel(post))
                            .padding(.top, 2)
                            .padding(.bottom, 2)
                    }
                    Divider()
                }
            }
        }
    }
}

#Preview {
    PostsView(selectedTeam: .constant(0))
}
