//
//  AuthManager.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation
import Alamofire
import Combine

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        isLoggedIn = getUserId() != nil
        if isLoggedIn {
//            fetchUser()
        }
    }
    
    func login(parameters: Parameters) {
        NetworkManager<UserAuth>.request(route: .login(parameters))
            .sink { completion in
                
            } receiveValue: { [weak self] userAuth in
                let user = User(id: userAuth.id, nickName: userAuth.nickName, isAdmin: userAuth.isAdmin, team: userAuth.team)
                self?.saveuser(user)
            }
            .store(in: &cancellables)
        
//        NetworkManager<UserAuth>.request(route: .login(parameters)) { result in
//            switch result {
//            case .success(let userAuth):
//                let user = User(id: userAuth.id, nickName: userAuth.nickName, isAdmin: userAuth.isAdmin, team: userAuth.team)
//                self.saveuser(user)
//                print("succeed to login! \(user.id)!")
//            case .failure(let error):
//                print("failed to login.. \(error.localizedDescription)")
//            }
//        }
    }

    func logout() {
        clearUserData()
    }
    
    func checkLoginStatus() {
        if isLoggedIn {
            print("state : Login..")
        } else {
            print("state: Logout..")
        }
    }

    func registerAndLogin(parameters: Parameters) {
        NetworkManager<UserAuth>.request(route: .signup(parameters))
            .sink { completion in
                
            } receiveValue: { [weak self] userAuth in
                let loginParameters: Parameters = [
                    "userId": parameters["userId"] as! String,
                    "password": parameters["password"] as! String
                ]
                self?.login(parameters: loginParameters)
            }
            .store(in: &cancellables)

//        NetworkManager<UserAuth>.request(route: .signup(parameters)) { result in
//            switch result {
//            case .success(let user):
//                let loginParameters: Parameters = [
//                    "userId": parameters["userId"] as! String,
//                    "password": parameters["password"] as! String
//                ]
//                self.login(parameters: loginParameters)
//                print("succeed to sign up! \(user.id)")
//            case .failure(let error):
//                print("failed to sign up.. \(error.localizedDescription)")
//            }
//        }
    }
    
    func saveuser(_ user: User) {
        let encodedData = try? JSONEncoder().encode(user)
        UserDefaults.standard.set(encodedData, forKey: "currentUser")
        currentUser = user
        isLoggedIn = true
        print("succeed to save user to userdefaults! \(user.id)")
    }

    private func getUserId() -> String? {
        // UserDefaults에서 user 정보를 가져옴
        if let encodedData = UserDefaults.standard.data(forKey: "currentUser"),
           let currentUser = try? JSONDecoder().decode(User.self, from: encodedData) {
            self.currentUser = currentUser
            print("succeed to get user from userdefaults! \(currentUser.id)")
            return currentUser.id
        }
        print("failed to get user from userdefaults..")
        return nil
    }
//    
//    func fetchUser(_ currentUser: User) {
//        NetworkManager<User>.callGet(urlString: "/users/\(currentUser.id)") { result in
//            switch result {
//            case .success(let user):
//                self.currentUser = user
//                print("succeed to get user!")
//            case .failure(let error):
//                print("failed to get user.. \(error.localizedDescription)")
//            }
//        }
//    }

    private func clearUserData() {
        // UserDefaults에서 사용자 정보 삭제
        UserDefaults.standard.removeObject(forKey: "currentUser")
        
        currentUser = nil
        isLoggedIn = false
        print("succeed to delete user to userdefaults! (lgoout)")
    }

}
