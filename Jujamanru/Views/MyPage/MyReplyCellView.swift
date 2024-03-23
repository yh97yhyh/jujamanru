//
//  MyReplyCellView.swift
//  Jujamanru
//
//  Created by 영현 on 3/23/24.
//

import SwiftUI

struct MyReplyCellView: View {
    @StateObject var viewModel: ReplyViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(viewModel.reply.createdBy)")
                    .font(.footnote)
                
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
    ReplyCellView(viewModel: ReplyViewModel(), postViewModel: PostViewModel())
}
