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
                    
                    Text("\(viewModel.post.teamName) / \(viewModel.post.modifiedDatetime) / 조회 \(viewModel.post.viewCount)")
                        .font(.footnote)
                        .foregroundColor(.gray)
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
    PostCellView(viewModel: PostViewModel())
}
