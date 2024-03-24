//
//  PostHeaderView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct PostHeaderView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: PostDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.post.title)
                Spacer()
            }
            
            Text("익명")
                .font(.footnote)
            
            HStack {
                if viewModel.post.teamId != nil {
                    Text("\(viewModel.post.teamName!) / \(viewModel.datetime) / 조회 \(viewModel.post.viewCount) / 댓글 \(viewModel.post.replyCount)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                } else {
                    Text("전체 / \(viewModel.datetime) / 조회 \(viewModel.post.viewCount) / 댓글 \(viewModel.post.replyCount)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                if myPageViewModel.user.id == viewModel.post.createdBy {
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.line")
                            .foregroundColor(.gray)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.gray)
                    }
                }
            }

        }
        .padding(.horizontal)
    }
}

#Preview {
    PostHeaderView(viewModel: PostDetailViewModel(postId: 4, userId: "ssg1"))
}
