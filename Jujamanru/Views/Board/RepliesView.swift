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
    @State private var isModalPresented = false
    @Environment(\.dismiss) private var dismiss
    
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
                
                Text("댓글 \(viewModel.replies.count)")
                    .font(.headline)
                
                Spacer()

            }
            .padding(.horizontal)
//            .padding(.bottom)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.replies, id: \.self) { reply in
                    ReplyCellView(viewModel: ReplyViewModel(reply), postViewModel: PostViewModel(postId: reply.postId, userId: myPageViewModel.user.id))
                    
                    Divider()
                }
            }
            
            Divider()
            
            Button {
                isModalPresented.toggle()
            } label: {
                Text("댓글쓰기")
            }
            .buttonStyle(ReplyWriteButtonStyle())
            .sheet(isPresented: $isModalPresented) {
                ReplyWriteView(viewModel: PostViewModel(postId: viewModel.postId, userId: myPageViewModel.user.id))
                    .presentationDetents([.height(80)])
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RepliesView(viewModel: RepliesViewModel(postId: 4))
}
