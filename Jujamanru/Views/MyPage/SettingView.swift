//
//  SettingView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var viewModel: MyPageViewModel
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: MyPostsView()) {
                    Text("작성글 보기")
                        .foregroundColor(.black)
                }
                NavigationLink(destination: MyRepliesView()) {
                    Text("작성댓글 보기")
                        .foregroundColor(.black)
                }
                NavigationLink(destination: ScrapView()) {
                    Text("스크랩 보기")
                        .foregroundColor(.black)
                }
//                NavigationLink(destination: Text("로그아웃")) {
//                    Text("로그아웃")
//                        .foregroundColor(.black)
//                }
                Button {
                    authManager.logout()
                } label: {
                    HStack {
                        Text("로그아웃")
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.black)
                    }
                }
                
            }
        }
    }
}

#Preview {
    SettingView()
}
