//
//  SettingView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct SettingView: View {
    @StateObject var viewModel = MyPageViewModel.shared
    
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: Text("")) {
                    Text("로그아웃")
                        .foregroundColor(.black)
                }
                NavigationLink(destination: Text("")) {
                    Text("작성댓글 보기")
                        .foregroundColor(.black)
                }
                NavigationLink(destination: Text("")) {
                    Text("스크랩 보기")
                        .foregroundColor(.black)
                }
                NavigationLink(destination: Text("")) {
                    Text("로그아웃")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    SettingView()
}
