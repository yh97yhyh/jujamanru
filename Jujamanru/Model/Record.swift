//
//  Record.swift
//  Jujamanru
//
//  Created by 영현 on 6/18/24.
//

import Foundation

struct Record: Identifiable, Codable, Hashable {
    let id: String
    let userId: String
    let gameResult: GameResult
    let images: [String]
    let text: String
}

enum GameResult: String, Codable {
    case win
    case draw
    case lose
}
