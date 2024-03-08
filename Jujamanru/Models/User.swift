//
//  User.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    var id: String
    var nickname: String
    var teamId: Int
    var teamName: String
    var createdDatetime: String
    var modifiedDatetime: String
}

extension User {
    static let MOCK_USER_SSG: User = .init(id: "juman01", nickname: "주만1", teamId: Team.SSG.id, teamName: Team.SSG.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_LG: User = .init(id: "juman02", nickname: "주만2", teamId: Team.LG.id, teamName: Team.LG.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_KIA: User = .init(id: "juman03", nickname: "주만3", teamId: Team.KIA.id, teamName: Team.KIA.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_KT: User = .init(id: "juman04", nickname: "주만4", teamId: Team.KT.id, teamName: Team.KT.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_HH: User = .init(id: "juman05", nickname: "주만5", teamId: Team.HH.id, teamName: Team.HH.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_KW: User = .init(id: "juman06", nickname: "주만6", teamId: Team.KW.id, teamName: Team.KW.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_SSG2: User = .init(id: "juman07", nickname: "주만7", teamId: Team.SSG.id , teamName: Team.SSG.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_KIA2: User = .init(id: "juman08", nickname: "주만8", teamId: Team.KIA.id, teamName: Team.KIA.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_KIA3: User = .init(id: "juman09", nickname: "주만9", teamId: Team.KIA.id, teamName: Team.KIA.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_KIA4: User = .init(id: "juman10", nickname: "주만10", teamId: Team.KIA.id, teamName: Team.KIA.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
    static let MOCK_USER_KIA5: User = .init(id: "juman11", nickname: "주만11", teamId: Team.KIA.id, teamName: Team.KIA.name, createdDatetime: "2024-03-08 17:52:00", modifiedDatetime: "2024-03-08 17:52:00")
}
