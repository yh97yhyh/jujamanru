//
//  MyPostsView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct MyPostsView: View {
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
                
                Text("작성글")
                    .font(.headline)
                
                Spacer()

            }
            .padding(.horizontal)
//            .padding(.bottom)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                if viewModel.posts.isEmpty {
                    Text("작성글이 없습니다.. 🙁")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.top)
                } else {
                    ForEach(viewModel.posts, id: \.self) { post in
                        MyPostCellView(viewModel: PostViewModel(post))
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
    MyPostsView()
}
