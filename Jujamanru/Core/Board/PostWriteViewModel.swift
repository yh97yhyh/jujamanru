//
//  PostWriteViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation
import Alamofire
import Combine

class PostWriteViewModel: ObservableObject {
    @Published var userId: String
    
    @Published var selectedTeam = 0
    @Published var title = ""
    @Published var text = ""
    
    var cancellables = Set<AnyCancellable>()

    
    init(userId: String) {
        self.userId = userId
    }
    
    func writePost(completion: @escaping (Result<Int, NetworkError>) -> Void) {
        var parameters = Parameters()
        if selectedTeam == 0 {
            parameters = [
                "title": title,
                "mustRead": false,
                "isNotice": false,
                "userId": userId,
                "text": text
            ]
        } else {
            parameters = [
                "title": title,
                "teamId": selectedTeam,
                "mustRead": false,
                "isNotice": false,
                "userId": userId,
                "text": text
            ]
        }
        
        NetworkManager<Int>.request(route: .writePost(parameters))
            .sink { completion in
                
            } receiveValue: { val in
                
            }
            .store(in: &cancellables)
    }
    
}
