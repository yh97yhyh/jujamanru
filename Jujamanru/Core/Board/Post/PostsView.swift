//
//  PostsView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct PostsView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @EnvironmentObject var teamViewModel: TeamViewModel
    @StateObject var viewModel = BoardViewModel.shared
    @Binding var selectedTeam: Int
    @State var isSeeNotice = true
    @State private var isEndReached: Bool = false
    
//    private var filteredPosts: [Post] {
//        if selectedTeam == 0 {
////            return viewModel.posts.sorted(by: { $0.createdDatetime > $1.createdDatetime })
//            return viewModel.posts
//        } else {
//            return viewModel.posts
////                .filter { $0.teamId == selectedTeam }
////                .sorted(by: { $0.createdDatetime > $1.createdDatetime })
//        }
//    }
    
    private var newPostsCount: Int {
        viewModel.posts.filter { post in
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let todayDateString = dateFormatter.string(from: currentDate)
            return post.modifiedDatetime.starts(with: todayDateString)
        }.count
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("새글 \(newPostsCount) / \(viewModel.totalCount)")
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
            
            ScrollView(showsIndicators: true) {
                if isSeeNotice {
                    
                }
                
                ForEach(viewModel.posts, id: \.self) { post in
                    NavigationLink(destination: PostDetailView(viewModel: PostDetailViewModel(postId: post.id, userId: myPageViewModel.user.id))) {
                        PostCellView(viewModel: PostViewModel(postId: post.id, userId: myPageViewModel.user.id))
                            .padding(.top, 2)
                            .padding(.bottom, 2)
                    }
                    Divider()
                }
                Color.clear
                    .frame(width: 0, height: 0, alignment: .bottom)
                    .onAppear {
                        isEndReached = true
                    }
            }
            .onChange(of: isEndReached) { isEndReached in
                if isEndReached {
                    viewModel.addPosts()
                    self.isEndReached = false
                }
            }
            
        }
    }
}

#Preview {
    PostsView(selectedTeam: .constant(0))
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
        .environmentObject(TeamViewModel())
}
