//
//  ReplyView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct RepliesView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: RepliesViewModel
//    @StateObject var postViewModel: PostViewModel
    @State var isWriteModalPresented = false
    @State var isEditModalPresented = false
    @Environment(\.dismiss) private var dismiss
    @State var isEndReached: Bool = false
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
                
                Text("댓글 \(viewModel.totalCount)")
                    .font(.headline)
                
                Spacer()

            }
            .padding(.horizontal)
//            .padding(.bottom)
            
            Divider()
            
            ScrollView(showsIndicators: true) {
                ForEach(viewModel.replies, id: \.self) { reply in
                    ReplyCellView(viewModel: ReplyViewModel(reply), postViewModel: PostViewModel(postId: reply.postId, userId: myPageViewModel.user.id), isWriteModalPresented: $isWriteModalPresented, isEditModalPresented: $isEditModalPresented, isReplyRemoved: $isReplyRemoved)
                        .sheet(isPresented: $isEditModalPresented ) {
                            ReplyEditView(viewModel: ReplyEditViewModel(reply))
                                .presentationDetents([.height(80)])
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
                    viewModel.addReplies(viewModel.postId)
                    self.isEndReached = false
                }
            }
            
            Divider()
            
            Button {
                isWriteModalPresented.toggle()
            } label: {
                Text("댓글쓰기")
            }
            .buttonStyle(ReplyWriteButtonStyle())
            .sheet(isPresented: $isWriteModalPresented) {
                ReplyWriteView(viewModel: ReplyWriteViewModel(postId: viewModel.postId, userId: myPageViewModel.user.id))
                    .presentationDetents([.height(80)])
            }
            .onChange(of: isWriteModalPresented) { isPresented in
                if !isPresented {
                    print("RepliesView - modal disappear")
                    viewModel.fetchReplies(viewModel.postId)
                }
            }
            .onChange(of: isEditModalPresented) { isPresented in
                if !isPresented {
                    print("RepliesView - modal disappear")
                    viewModel.fetchReplies(viewModel.postId)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !isInit {
                print("onAppear")
            }
            isInit = false
        }
        .onChange(of: isReplyRemoved) { isPresented in
            if isReplyRemoved {
                print("RepliesView - isReplyRemoved")
                viewModel.fetchReplies(viewModel.postId)
                isReplyRemoved = false
            }
        }
    }
}

#Preview {
    RepliesView(viewModel: RepliesViewModel(postId: 4))
}
