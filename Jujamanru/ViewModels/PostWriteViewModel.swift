//
//  PostWriteViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation
import Alamofire

class PostWriteViewModel: ObservableObject {
    @Published var userId: String
    
    @Published var selectedTeam = 0
    @Published var title = ""
    @Published var text = ""
    
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
        NetworkManager<Int>.callPost(urlString: "/posts", parameters: parameters) { result in
            completion(result)
        }
    }
    
}
