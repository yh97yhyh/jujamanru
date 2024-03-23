//
//  PostDetailView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct PostDetailView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: PostViewModel
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
                
                if viewModel.post.teamId != 0 {
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
                    ReplyCellView(viewModel: ReplyViewModel(reply), postViewModel: viewModel)
                    
                    Divider()
                }
                
                Button {
                    isModalPresented.toggle()
                } label: {
                    Text("댓글쓰기")
                }
                .buttonStyle(ReplyWriteButtonStyle())
                .sheet(isPresented: $isModalPresented) {
                    ReplyWriteView(viewModel: viewModel)
                        .presentationDetents([.height(80)])
                }
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
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
    PostDetailView(viewModel: PostViewModel(postId: 4, userId: "ssg1"))
}
