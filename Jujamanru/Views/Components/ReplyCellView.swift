//
//  ReplyCellView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct ReplyCellView: View {
    @StateObject var viewModel: ReplyViewModel
    @StateObject var postViewModel: PostViewModel
    
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
            }
            
            Text(viewModel.reply.text)
                .font(.subheadline)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ReplyCellView(viewModel: ReplyViewModel(), postViewModel: PostViewModel(postId: 4, userId: "ssg1"))
}
