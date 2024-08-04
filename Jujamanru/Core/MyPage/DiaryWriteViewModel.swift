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
    @Published var gameResult: GameResult = .win {
        didSet {
            print("game result : \(gameResult.rawValue)")
        }
    }
    @Published var myTeam: Team = .MOCK_TEAMS[0]
    @Published var opponentTeam: Team = .MOCK_TEAMS[1]
    @Published var matchTeamId: Team = .MOCK_TEAMS[0]
    @Published var gameDate = Date()
    @Published var selectedImages: [UIImage] = [] {
        didSet {
            print("selected images : \(selectedImages)")
        }
    }
    @Published var text: String = ""
    var userId: String
    
    var cancellables = Set<AnyCancellable>()
    
    init(userId: String) {
        self.userId = userId
    }
    
    /*
     {"myTeamId" : "1", "opponentTeamId" : "2", "gameResult" : "WIN", "text" : "이겼다!!!!!!!!!!!", "matchDate" : "2024-06-22" , "userId" : "ssg1"}
     */
    func writeGameRecord() {
        var parameters = Parameters()
        parameters = [
            "myTeamId" : myTeam.id,
            "opponentTeamId" : opponentTeam.id,
            "gameResult" : gameResult.rawValue,
            "text": text,
            "matchDate" : dateToString(),
            "userId" : userId
        ]
        
        NetworkManager<GameRecord>.requestFormData(route: .writeGameRecordWithImages(parameters: parameters, images: selectedImages))
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error occurred: \(error)")
                }
            } receiveValue: { [weak self] gameRecord in
                print("succeed to write game record! \(gameRecord.id)")
            }.store(in: &cancellables)
    }
    
    private func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let formattedDate = formatter.string(from: gameDate)
        return formattedDate
    }
}
