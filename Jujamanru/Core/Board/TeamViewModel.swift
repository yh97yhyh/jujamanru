//
//  TeamViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import Foundation

class TeamViewModel: ObservableObject {
    static let shared = TeamViewModel()
    
    @Published var teams: [Team]
    
    init(_ teams: [Team] = Team.MOCK_TEAMS) {
        self.teams = teams
        fetchTeams()
    }
    
    func fetchTeams() {
        NetworkManager<[Team]>.request(route: .getTeams) { result in
            switch result {
            case .success(let teams):
                self.teams = teams
                print("succeed to get teams!")
            case .failure(let error):
                print("failed to get teams.. \(error.localizedDescription)")
            }
        }
    }
}
