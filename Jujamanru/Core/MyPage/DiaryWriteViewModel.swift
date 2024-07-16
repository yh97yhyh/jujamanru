//
//  DiaryWriteViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 7/16/24.
//

import Foundation
import Alamofire
import Combine

class DiaryWriteViewModel: ObservableObject {
    @Published var gameResult: GameResult = .win
    @Published var myTeam: Team = .MOCK_TEAMS[0]
    @Published var matchTeamId: Team = .MOCK_TEAMS[0]
    @Published var gameDate = Date()
    @Published var selectedImages: [UIImage] = [] {
        didSet {
            print("selected images : \(selectedImages)")
        }
    }
    @Published var text: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
}
