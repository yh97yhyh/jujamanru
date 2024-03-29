//
//  RegisterationViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation
import Alamofire

class RegisterationViewModel: ObservableObject {
    static let shared = RegisterationViewModel()
    
    @Published var id = ""
    @Published var password = ""
    @Published var nickname = ""
    
    func createUser() {
        let parameters: Parameters = [
                "userId": id,
                "password": password,
                "nickName": nickname,
                "isAdmin": false
            ]
        
        AuthManager.shared.registerAndLogin(parameters: parameters)
        
        clear()
    }
    
    
    private func clear() {
        id = ""
        password = ""
        nickname = ""
    }
}

