//
//  PostTextView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct PostTextView: View {
    @StateObject var viewModel: PostViewModel
    
    
    var body: some View {
        VStack {
            Text(viewModel.post.text)
                .frame(height: 500, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

#Preview {
    PostTextView(viewModel: PostViewModel())
}
