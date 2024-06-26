//
//  DiaryDetailViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 6/25/24.
//

import Foundation
import Alamofire
import Combine

class DiaryDetailViewModel: ObservableObject {
    
    var gameRecord: GameRecord
    @Published var gameResult: String = ""
    @Published var matchTeams: String = ""
    @Published var gameDate: String = ""
    @Published var images: [String] = []
    @Published var text: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ gameRecord: GameRecord) {
        self.gameRecord = gameRecord
        
//        self.text = gameRecord.text
//        self.gameResult = getGameResult()
//        self.matchTeams = getMatchTeams()
//        self.gameDate = getGameDate()
//        self.images = gameRecord.images ?? []
        
        self.getGmaeRecord()
    }
    
    private func getGmaeRecord() {
        NetworkManager<GameRecord>.request(route: .getGameRecord(gameRecordId: gameRecord.id))
            .sink { completion in
                switch completion {
                case .finished:
                    print("Request finished") // Optional: Handle completion if needed
                case .failure(let error):
                    print("Error: \(error)") // Handle error if needed
                }
            } receiveValue: { [weak self] gameRecord in
                self?.gameRecord = gameRecord
                self?.images = gameRecord.images ?? []
                self?.text = gameRecord.text
                self?.gameResult = self?.getGameResult() ?? ""
                self?.matchTeams = self?.getMatchTeams() ?? ""
                self?.gameDate = self?.getGameDate() ?? ""
            }.store(in: &cancellables)
    }
    
    private func getGameResult() -> String {
        switch gameRecord.gameResult {
        case .win:
            String("승리! 😆")
        case .draw:
            String("무승부 😐")
        case .lose:
            String("패배 😔")
        }
    }
    
    private func getMatchTeams() -> String {
        return "\(gameRecord.myTeamName) VS \(gameRecord.opponentTeamName)"
    }
    
    private func getGameDate() -> String {
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
}
