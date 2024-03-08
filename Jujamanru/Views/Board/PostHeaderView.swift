//
//  PostHeaderView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct PostHeaderView: View {
    @StateObject var viewModel: PostViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.post.title)
                Spacer()
            }
            
            Text("익명")
                .font(.footnote)
            
            Text("\(viewModel.post.teamName) / \(viewModel.datetime) / 조회 \(viewModel.post.viewCount) / 댓글 \(viewModel.post.replyCount)")
                .font(.footnote)
                .foregroundColor(.gray)

        }
        .padding(.horizontal)
    }
}

#Preview {
    PostHeaderView(viewModel: PostViewModel())
}
