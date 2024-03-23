//
//  MyRepliesView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct MyRepliesView: View {
    @StateObject var viewModel = MyPageViewModel.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Spacer()
                
                Text("작성댓글")
                    .font(.headline)
                
                Spacer()

            }
            .padding(.horizontal)
//            .padding(.bottom)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                if viewModel.replies.isEmpty {
                    Text("작성댓글이 없습니다.. 🙁")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.top)
                } else {
                    ForEach(viewModel.replies, id: \.self) { reply in
                        MyReplyCellView(viewModel: ReplyViewModel(reply))
                        
                        Divider()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MyRepliesView()
}
