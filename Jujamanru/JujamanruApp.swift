//
//  JujamanruApp.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

@main
struct JujamanruApp: App {
    @StateObject var authManager = AuthManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}
