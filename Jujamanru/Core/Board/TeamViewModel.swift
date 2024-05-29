//
//  TeamViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation
import Combine

class TeamViewModel: ObservableObject {
    static let shared = TeamViewModel()
    
    @Published var teams: [Team]
    
    var cancellables = Set<AnyCancellable>()
    
    init(_ teams: [Team] = Team.MOCK_TEAMS) {
        self.teams = teams
        fetchTeams()
    }
    
    func fetchTeams() {
        NetworkManager<[Team]>.request(route: .getTeams)
            .sink { _ in
                
            } receiveValue: { [weak self] teams in
                self?.teams = teams
            }
            .store(in: &cancellables)
    }
}
