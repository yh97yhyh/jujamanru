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
                
                Button {
                    
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.gray)
                }
            }
            
            Text(viewModel.reply.text)
                .font(.subheadline)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MyReplyCellView(viewModel: ReplyViewModel())
}
