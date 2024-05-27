//
//  PostDetailView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct PostDetailView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var boardViewModel = BoardViewModel.shared
    @StateObject var viewModel: PostDetailViewModel
    @State var isWriteModalPresented = false
    @State var isEditModalPresented = false
    @Environment(\.dismiss) private var dismiss
    @State var isInit = true
    @State var isReplyRemoved = false

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Spacer()
                
                if viewModel.post.teamId == nil {
                    Text("전체")
                        .font(.headline)
                } else {
                    Text(viewModel.post.teamName!)
                        .font(.headline)
                }
                
                Spacer()
            }
            .padding(.horizontal)
//            .padding(.bottom)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                PostHeaderView(viewModel: viewModel)
                
                Divider()
                
                PostTextView(viewModel: viewModel)
                
                Rectangle()
                    .fill(Color(UIColor(hexCode: "#EFEFEF")))
                    .frame(width: nil, height: 16)
                
                HStack {
                    Text("댓글 \(viewModel.post.replyCount)")
                    Spacer()
                    NavigationLink(destination: RepliesView(viewModel: RepliesViewModel(postId: viewModel.post.id))) {
                        Text("더보기")
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                ForEach(viewModel.post.replies ?? [], id: \.self) { reply in
                    ReplyCellView(viewModel: ReplyViewModel(reply), postViewModel: PostViewModel(postId: viewModel.post.id, userId: myPageViewModel.user.id), isWriteModalPresented: $isWriteModalPresented, isEditModalPresented: $isEditModalPresented, isReplyRemoved: $isReplyRemoved)
                        .sheet(isPresented: $isEditModalPresented ) {
                            ReplyEditView(viewModel: ReplyEditViewModel(reply))
                                .presentationDetents([.height(80)])
                        }
                    
                    Divider()
                }
                
                Button {
                    isWriteModalPresented.toggle()
                } label: {
                    Text("댓글쓰기")
                }
                .buttonStyle(ReplyWriteButtonStyle())
                .sheet(isPresented: $isWriteModalPresented) {
                    ReplyWriteView(viewModel: ReplyWriteViewModel(postId: viewModel.post.id, userId: myPageViewModel.user.id))
                        .presentationDetents([.height(80)])
                }
                .onChange(of: isWriteModalPresented) { isPresented in
                    if !isPresented {
                        print("PostDetailView - modal disappear")
                        viewModel.fetchPost(viewModel.post.id, myPageViewModel.user.id, isAddCount: false)
                    }
                }
                .onChange(of: isEditModalPresented) { isPresented in
                    if !isPresented {
                        print("PostDetailView - modal disappear")
                        viewModel.fetchPost(viewModel.post.id, myPageViewModel.user.id, isAddCount: false)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !isInit {
                viewModel.fetchPost(viewModel.post.id, myPageViewModel.user.id, isAddCount: true)
            }
            isInit = false
        }
        .onChange(of: isReplyRemoved) { isPresented in
            if isReplyRemoved {
                print("PostDetailView - isReplyRemoved")
                viewModel.fetchPost(viewModel.post.id, myPageViewModel.user.id, isAddCount: false)
                isReplyRemoved = false
            }
        }
    }
}

struct ReplyWriteButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .font(.subheadline)
//            .fontWeight(.semibold)
            .frame(height: 32)
//            .background(.white)
            .foregroundColor(.black)
            .cornerRadius(6)
//            .overlay(
//                RoundedRectangle(cornerRadius: 6)
//                    .stroke(.gray, lineWidth: 1)
//            )
//            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

#Preview {
    PostDetailView(viewModel: PostDetailViewModel(postId: 4, userId: "ssg1"))
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
}
