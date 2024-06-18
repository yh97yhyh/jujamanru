//
//  Team.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

struct Team: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
}

extension Team {
    static let MOCK_TEAMS: [Team] = [
        .init(id: 1, name: "엘지"),
        .init(id: 2, name: "KT"),
        .init(id: 3, name: "SSG"),
        .init(id: 4, name: "엔씨"),
        .init(id: 5, name: "두산"),
        .init(id: 6, name: "기아"),
        .init(id: 7, name: "롯데"),
        .init(id: 8, name: "삼성"),
        .init(id: 9, name: "한화"),
        .init(id: 10, name: "키움"),
    ]
}
