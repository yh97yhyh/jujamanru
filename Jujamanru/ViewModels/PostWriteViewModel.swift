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
    
    
    func writePost() {
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
            switch result {
            case .success(let postId):
                print("succeed to write post! \(postId)!")
            case .failure(let error):
                print("failed to write post.. \(error.localizedDescription)")
            }
        }
    }
    
}
