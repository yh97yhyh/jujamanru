//
//  MainTabView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .ignoresSafeArea()
                TabView(selection: $selectedIndex) {
                    HomeView(viewModel: getHomeViewModel())
                        .onAppear {
                            selectedIndex = 0
                        }
                        .tabItem {
                            Image(systemName: "house")
                            Text("홈")
                        }
                        .tag(0)
                    BoardView()
                        .onAppear {
                            selectedIndex = 1
                        }
                        .tabItem {
                            Image(systemName: "list.bullet.clipboard.fill")
                            Text("게시판")
                        }
                        .tag(1)
                    MyPageView()
                        .onAppear {
                            selectedIndex = 2
                        }
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("마이페이지")
                        }
                        .tag(2)
                }
                .accentColor(.black)
            }
        }
    }
    
    func getHomeViewModel() -> HomeViewModel {
        if myPageViewModel.user.team != nil {
            HomeViewModel(myTeamId: myPageViewModel.user.team!.id)
        } else {
            HomeViewModel()
        }
    }
}

#Preview {
    MainTabView()
}
