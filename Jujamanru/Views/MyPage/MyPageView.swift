//
//  MyPageView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var viewModel: MyPageViewModel
    @State private var isInit = true
    
    var body: some View {
        VStack {
            HStack {
                Text("주자만루")
                    .font(.headline)
                Spacer()
                
                NavigationLink(destination: Text("")) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                .disabled(true)
                .opacity(0.0)

            }
            .padding(.horizontal)
            .padding(.bottom)
            
            ProfileHeaderView()
                .padding(.bottom)
            
            SettingView()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !isInit {
                viewModel.fetchMyTeam()
                viewModel.fetchMyPosts()
                viewModel.fetchMyReplies()
            }
            isInit = false
        }
    }
}

#Preview {
    MyPageView()
}
