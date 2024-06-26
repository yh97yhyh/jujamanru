//
//  Record.swift
//  Jujamanru
//
//  Created by 영현 on 6/18/24.
//

import Foundation

struct GameRecord: Codable, Identifiable, Hashable {
    let id: Int
    let matchDate: String
    let myTeamId: Int
    let myTeamName: String
    let opponentTeamId: Int
    let opponentTeamName: String
    let gameResult: GameResult
    let text: String
    let createdBy: String
    let createdDatetime: String
    let images: [String]?
}

enum GameResult: String, Codable {
    case win = "WIN"
    case draw = "DRAW"
    case lose = "LOSE"
}

extension GameRecord {
    static let MOCK_GAME_RECORS: [GameRecord] = [
        .init(id: 1, matchDate: "2024-06-01", myTeamId: 1, myTeamName: "SSG", opponentTeamId: 2, opponentTeamName: "기아", gameResult: .win, text: "아싸 이겼다~~", createdBy: "ssg1", createdDatetime: "2024-06-01 23:17:10", images: ["nari1539_2_0_1719237372241.jpg", "nari1539_2_1_1719237372261.jpg"]),
        .init(id: 1, matchDate: "2024-06-02", myTeamId: 1, myTeamName: "SSG", opponentTeamId: 2, opponentTeamName: "기아", gameResult: .win, text: "또 이겼당 ㅎㅎㅎㅎ", createdBy: "ssg1", createdDatetime: "2024-06-02 23:17:10", images: [])
    ]
}
