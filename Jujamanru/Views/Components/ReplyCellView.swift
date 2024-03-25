//
//  ReplyCellView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct ReplyCellView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: ReplyViewModel
    @StateObject var postViewModel: PostViewModel
    @Binding var isWriteModalPresented: Bool
    @Binding var isEditModalPresented: Bool
    @Binding var isReplyRemoved: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if postViewModel.post.createdBy == viewModel.reply.createdBy {
                        Text("글쓴이")
                            .font(.footnote)
                } else {
                    Text("익명")
                        .font(.footnote)
                }
                
                Text(viewModel.datetime)
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Spacer()
                
                if myPageViewModel.user.id == viewModel.reply.createdBy {
                    Button {
//                        isWriteModalPresented.toggle()
                        isEditModalPresented.toggle()
                    } label: {
                        Image(systemName: "pencil.line")
                            .foregroundColor(.gray)
                    }
                    
                    Button {
                        viewModel.deleteReply { result in
                            switch result {
                            case 1:
                                print("succeed to delete reply!")
                            case 2:
                                print("failed to delete reply..")
                            default:
                                print("failed to delete reply..")
                            }
                        }
                        isReplyRemoved = true
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Text(viewModel.reply.text)
                .font(.subheadline)
        }
        .padding(.horizontal)
        .onAppear {
//            print(viewModel.reply)
        }
    }
}

//#Preview {
//    ReplyCellView(viewModel: ReplyViewModel(), postViewModel: PostViewModel(postId: 4, userId: "ssg1"), isWriteModalPresented: .constant(false), isEditModalPresented: .constant(false), isReplyRemoved: .constant(false))
//}
