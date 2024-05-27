//
//  LoginViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation
import Alamofire

class LoginViewModel: ObservableObject {
    static let shared = LoginViewModel()
    
    @Published var id = ""
    @Published var password = ""
    
    func login() {
        let parameters: Parameters = [
            "userId": id,
            "password": password,
        ]
        
        AuthManager.shared.login(parameters: parameters)
    
        clear()
    }
    
    private func clear() {
        id = ""
        password = ""
    }
}

