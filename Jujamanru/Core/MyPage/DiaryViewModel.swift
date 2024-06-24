//
//  DiaryViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 6/18/24.
//

import Foundation
import Alamofire
import Combine

class DiaryViewModel: ObservableObject {
    @Published var user: User
    @Published var records: [GameRecord]
    @Published var visitCount: Int = 0
    @Published var winRate: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ user: User, records: [GameRecord] = []) {
        self.user = user
        self.records = records
        
        fetchMyGameRecords()
    }
    
    func fetchMyGameRecords() {
        NetworkManager<[GameRecord]>.request(route: .getGameRecords(userId: user.id))
            .sink { _ in
                
            } receiveValue: { [weak self] gameRecords in
                self?.records = gameRecords
                self?.visitCount = gameRecords.count
                self?.winRate = self?.getWinRate() ?? ""
            }.store(in: &cancellables)
    }
    
    private func getWinRate() -> String {
        if visitCount < 1 {
            return "승률 0.0%"
        }
        
        let winCount = records.filter { $0.gameResult == .win }.count
        let winRate = Double(winCount) / Double(visitCount)
        return String("승률 ") + String(format: "%.1f%%", winRate * 100)
    }
}

