//
//  PostTextView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct PostTextView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: PostDetailViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.post.text!)
                .frame(height: 500, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

#Preview {
    PostTextView(viewModel: PostDetailViewModel(postId: 4, userId: "ssg1"))
}
