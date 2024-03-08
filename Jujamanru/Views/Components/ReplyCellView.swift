//
//  ReplyCellView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct ReplyCellView: View {
    @StateObject var viewModel: ReplyViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if viewModel.reply.isPoster {
                    Text("글쓴이")
                        .font(.callout)
                } else {
                    Text("익명")
                        .font(.callout)
                }
                
                Text(viewModel.reply.modifiedDatetime)
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
    ReplyCellView(viewModel: ReplyViewModel())
}
