//
//  MyPostCellView.swift
//  Jujamanru
//
//  Created by 영현 on 3/23/24.
//

import SwiftUI

struct MyPostCellView: View {
    @StateObject var viewModel: PostViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.post.title)
                        .font(.callout)
//                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .foregroundColor(.black)
                    
                    if viewModel.post.teamId != nil {
                        Text("\(viewModel.post.teamName!) / \(viewModel.datetime) / 조회 \(viewModel.post.viewCount)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    } else {
                        Text("전체 / \(viewModel.datetime) / 조회 \(viewModel.post.viewCount)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Text("\(viewModel.post.replyCount)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Button {
                    
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.gray)
                }
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    PostCellView(viewModel: PostViewModel(postId: 4, userId: "ssg1"))
}
