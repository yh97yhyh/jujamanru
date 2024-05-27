//
//  HomeView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: HomeViewModel
    @State private var isInit = true
    
    var body: some View {
        VStack {
            HStack {
                Text("주자만루")
                    .font(.headline)
                Spacer()
                
                NavigationLink(destination: Text("")) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                .disabled(true)
                .opacity(0.0)

            }
            .padding(.horizontal)
            .padding(.bottom)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("전체 인기글 🔥")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.popularPosts.prefix(5), id: \.self) { post in
                        Divider()
                        NavigationLink(destination: PostDetailView(viewModel: PostDetailViewModel(postId: post.id, userId: myPageViewModel.user.id))) {
                            PostCellView(viewModel: PostViewModel(postId: post.id, userId: myPageViewModel.user.id))
                                .padding(.top, 2)
                                .padding(.bottom, 2)
                        }
                    }
                }
                
                Rectangle()
                    .fill(Color(UIColor(hexCode: "#EFEFEF")))
                    .frame(width: nil, height: 12)
//                Divider()
                
                VStack {
                    HStack {
                        Text("우리팀 인기글 🏟️")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .padding()
                
                if viewModel.myTeamPopularPosts.isEmpty && myPageViewModel.user.team == nil {
                    Text("팀을 선택해주세요!")
                        .foregroundColor(.gray)
                        .padding(.top)
                } else if viewModel.myTeamPopularPosts.isEmpty && myPageViewModel.user.team != nil {
                    Text("우리팀 인기글이 없습니다.. 🙁")
                        .foregroundColor(.gray)
                        .padding(.top)
                
                } else {
//                    Divider()
                    ScrollView(showsIndicators: false) {
                        ForEach(viewModel.myTeamPopularPosts, id: \.self) { post in
                            Divider()
                            NavigationLink(destination: PostDetailView(viewModel: PostDetailViewModel(postId: post.id, userId: myPageViewModel.user.id))) {
                                PostCellView(viewModel: PostViewModel(postId: post.id, userId: myPageViewModel.user.id))
                                    .padding(.top, 2)
                                    .padding(.bottom, 2)
                            }
                        }
                    }
                }
                
                Rectangle()
                    .fill(Color(UIColor(hexCode: "#EFEFEF")))
                    .frame(width: nil, height: 12)
//                Divider()

                VStack {
                    HStack {
                        Text("공지 ")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .padding()
                
//                Divider()
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.notices, id: \.self) { post in
                        Divider()
                        NavigationLink(destination: PostDetailView(viewModel: PostDetailViewModel(postId: post.id, userId: myPageViewModel.user.id))) {
                            PostCellView(viewModel: PostViewModel(postId: post.id, userId: myPageViewModel.user.id))
                                .padding(.top, 2)
                                .padding(.bottom, 2)
                        }
                    }
                    Divider()
                }
            }
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !isInit {
                viewModel.fetchPopularPosts()
                if myPageViewModel.user.team != nil {
                    viewModel.fetchMyTeamPopularPosts(myPageViewModel.user.team!.id)
                }
                viewModel.fetchNotices()
            }
            isInit = false
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(myTeamId: 1))
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
}
