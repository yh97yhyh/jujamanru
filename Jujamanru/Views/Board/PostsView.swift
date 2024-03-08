//
//  PostsView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct PostsView: View {
    @StateObject var viewModel = BoardViewModel.shared
    @Binding var selectedTeam: Int
    @State var isSeeNotice = true
    
    private var filteredProducts: [Post] {
        if selectedTeam == 0 {
            return viewModel.posts
        } else {
            return viewModel.posts.filter { $0.teamId == selectedTeam }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("새글 0 / \(filteredProducts.count)")
                    .font(.subheadline)
                Spacer()
                Button("공지보기") {
                    isSeeNotice.toggle()
                }
                .buttonStyle(FilterButtonStyle())
                .font(.subheadline)
            }
            .padding(.horizontal)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                if isSeeNotice {
                    
                }
                
                ForEach(filteredProducts, id: \.self) { post in
                    NavigationLink(destination: Text("")) {
                        PostCellView(viewModel: PostViewModel(post))
                            .padding(.top, 2)
                            .padding(.bottom, 2)
//                            .frame(height: nil)
//                            .border(Color.gray, width: 1)
                    }
                    Divider()
                }
            }
        }
    }
}

#Preview {
    PostsView(selectedTeam: .constant(0))
}
