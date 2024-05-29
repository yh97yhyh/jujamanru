//
//  PostEditViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/26/24.
//

import Foundation
import Alamofire
import Combine

class PostEditViewModel: ObservableObject {
    @Published var post: Post
    @Published var selectedTeam = 0
    @Published var title = ""
    @Published var text = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init(post: Post) {
        self.post = post
        self.selectedTeam = post.teamId ?? 0
        self.title = post.title
        self.text = post.text!
    }
    
    func editPost(completion: @escaping (Result<Int, NetworkError>) -> Void) {
        var parameters = Parameters()
        if selectedTeam != 0 {
            parameters = [
                "title": title,
                "teamId": selectedTeam,
                "isNotice": post.isNotice,
                "mustRead": post.mustRead,
                "text": text
            ]
        } else {
            parameters = [
                "title": title,
                "isNotice": post.isNotice,
                "mustRead": post.mustRead,
                "text": text
            ]
        }
        
        NetworkManager<Int>.request(route: .updatePost(postId: post.id, parameters: parameters))
            .sink { _ in
                
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
}
