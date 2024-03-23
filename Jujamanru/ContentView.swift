//
//  ContentView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack {
            if authManager.isLoggedIn {
                MainTabView()
                    .environmentObject(getMyPageViewModel())
                    .environmentObject(getTeamViewModel())
            } else {
                LoginView()
            }
        }
    }
    
    func getMyPageViewModel() -> MyPageViewModel {
        if let currentUser = authManager.currentUser {
            return MyPageViewModel(currentUser)
        } else {
            return MyPageViewModel()
        }
    }
    
    func getTeamViewModel() -> TeamViewModel {
        return TeamViewModel()
    }
}

#Preview {
    ContentView()
}
