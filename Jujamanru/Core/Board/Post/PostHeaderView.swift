//
//  PostHeaderView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct PostHeaderView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var boardViewModel = BoardViewModel.shared
    @StateObject var viewModel: PostDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
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
                    NavigationLink(destination: 
                                    PostEditView(postDetailViewModel: PostDetailViewModel(postId: viewModel.post.id, userId: myPageViewModel.user.id),
                                                 viewModel: PostEditViewModel(post: viewModel.post))) {
                        Image(systemName: "pencil.line")
                            .foregroundColor(.gray)
                    }
                    
                    Button {
                        viewModel.deletePost { result in
                            switch result {
                            case 1:
                                print("succeed to delete post!")
                            case 2:
                                print("failed to delete post..")
                            default:
                                print("failed to delete post..")
                            }
                            dismiss()
                        }
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
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
}
