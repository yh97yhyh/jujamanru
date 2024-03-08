//
//  MyPageViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

class MyPageViewModel: ObservableObject {
    static let shared = MyPageViewModel()
    
    @Published var user: User
    
    init(_ user: User = User.MOCK_USER_SSG) {
        self.user = user
    }
}
