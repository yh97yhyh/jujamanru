//
//  DiaryCellViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 6/25/24.
//

import Foundation
import Alamofire
import Combine

class DiaryCellViewModel: ObservableObject {
    @Published var gameRecord: GameRecord
    @Published var gameResult: String = ""
    @Published var matchTeams: String = ""
    @Published var gameDate: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ gameRecord: GameRecord) {
        self.gameRecord = gameRecord
        self.gameResult = getGameResult()
        self.matchTeams = getMatchTeams()
        self.gameDate = getMatchDate()
    }
    
    private func getGameResult() -> String {
        switch gameRecord.gameResult {
        case .win:
            String("😆")
        case .draw:
            String("😐")
        case .lose:
            String("😔")
        }
    }
    
    private func getMatchTeams() -> String {
        return "\(gameRecord.myTeamName) VS \(gameRecord.opponentTeamName)"
    }
    
    private func getMatchDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: gameRecord.matchDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy.MM.dd"
            
            let formattedDate = outputFormatter.string(from: date)
            
            return formattedDate
        } else {
            return gameRecord.matchDate
        }
    }
    
//    func fetchGameRecord(_ gameRecordId: Int) {
//        NetworkManager<GameRecord>.request(route: .getGameRecord(gameRecordId: gameRecordId))
//            .sink { _ in
//                
//            } receiveValue: { [weak self] gameRecord in
//                self?.gameRecord = gameRecord
//            }.store(in: &cancellables)
//    }
}
