//
//  ScrapView.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import SwiftUI

struct ScrapView: View {
    @EnvironmentObject var viewModel: MyPageViewModel
    
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
                
                Text("스크랩")
                    .font(.headline)
                
                Spacer()

            }
            .padding(.horizontal)
//            .padding(.bottom)
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                if viewModel.scraps.isEmpty {
                    Text("스크랩한 글이 없습니다.. 🙁")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.top)
                } else {
                    ForEach(viewModel.scraps, id: \.self) { scrap in
                        NavigationLink(destination: PostDetailView(viewModel: PostViewModel(postId: scrap.id, userId: viewModel.user.id))) {
                            PostCellView(viewModel: PostViewModel(postId: scrap.id, userId: viewModel.user.id))
                        }
                        
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
    ScrapView()
}
