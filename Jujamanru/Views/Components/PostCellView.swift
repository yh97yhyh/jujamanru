//
//  PostCellView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct PostCellView: View {
    @StateObject var viewModel: PostViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.post.title)
                        .font(.callout)
//                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    if viewModel.post.teamId != nil {
                        
                        HStack {
                            Text("\(viewModel.post.teamName!)")
                                .font(.footnote)
                                .foregroundColor(.blue)
                            
                            Text("\(viewModel.datetime) / 조회 \(viewModel.post.viewCount)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("")
                            .font(.footnote)
                            .foregroundColor(.blue)
                        
                        Text("\(viewModel.datetime) / 조회 \(viewModel.post.viewCount)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Text("\(viewModel.post.replyCount)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    PostCellView(viewModel: PostViewModel(postId: 4, userId: "ssg1"))
}
