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

//enum Team: Identifiable, Hashable {
//    case LG
//    case KT
//    case SSG
//    case NC
//    case DS
//    case KIA
//    case LT
//    case SS
//    case HH
//    case KW
//    // Add more cases as needed
//    
//    var id: Int {
//        switch self {
//        case .LG:
//            return 1
//        case .KT:
//            return 2
//        case .SSG:
//            return 3
//        case .NC:
//            return 4
//        case .DS:
//            return 5
//        case .KIA:
//            return 6
//        case .LT:
//            return 7
//        case .SS:
//            return 8
//        case .HH:
//            return 9
//        case .KW:
//            return 10
//        }
//    }
//    
//    var name: String {
//        switch self {
//        case .LG:
//            return "엘지"
//        case .KT:
//            return "KT"
//        case .SSG:
//            return "SSG"
//        case .NC:
//            return "엔씨"
//        case .DS:
//            return "두산"
//        case .KIA:
//            return "기아"
//        case .LT:
//            return "롯데"
//        case .SS:
//            return "삼성"
//        case .HH:
//            return "한화"
//        case .KW:
//            return "키움"
//        }
//    }
//}
//
//extension Team {
//    static let TEAMS = [Team.LG, Team.KT, Team.SSG, Team.NC, Team.DS, Team.KIA, Team.LT, Team.SS, Team.HH, Team.KW]
//}
