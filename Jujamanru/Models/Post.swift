//
//  Post.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

struct Post: Identifiable, Codable, Hashable {
    var id: Int
    var title: String
    var text: String
    var teamId: Int
    var teamName: String
    var viewCount: Int
    var replyCount: Int
    var createdBy: String
    var createdDatetime: String
    var modifiedDatetime: String
}

extension Post {
    static let MOCK_POSTS: [Post] = [
        .init(id: 0, title: "아 제발 봐주세요", text: "ㅈㄱㄴ", teamId: Team.KIA.id, teamName: Team.KIA.name, viewCount: 36, replyCount: 4, createdBy: User.MOCK_USER_KIA.id, createdDatetime: "2024-03-08 18:49:00", modifiedDatetime: "2024-03-08 18:49:00"),
        .init(id: 1, title: "오 오늘 좀 잘한다", text: "선발 전원 홈런이라니", teamId: Team.LG.id, teamName: Team.LG.name, viewCount: 33, replyCount: 0, createdBy: User.MOCK_USER_LG.id, createdDatetime: "2024-03-08 18:52:00", modifiedDatetime: "2024-03-08 18:52:00"),
        .init(id: 2, title: "헉 대박", text: "수비 ㅁㅊ", teamId: Team.HH.id, teamName: Team.HH.name, viewCount: 31, replyCount: 0, createdBy: User.MOCK_USER_HH.id, createdDatetime: "2024-03-08 18:53:00", modifiedDatetime: "2024-03-08 18:53:00"),
        .init(id: 3, title: "아니 이걸;;", text: ";;;;뭔데", teamId: Team.KT.id, teamName: Team.KT.name, viewCount: 19, replyCount: 0, createdBy: User.MOCK_USER_KT.id, createdDatetime: "2024-03-08 18:55:00", modifiedDatetime: "2024-03-08 18:55:00"),
        .init(id: 4, title: "와 이걸 사네 굿", text: "오우예", teamId: Team.SSG.id, teamName: Team.SSG.name, viewCount: 17, replyCount: 0, createdBy: User.MOCK_USER_SSG.id, createdDatetime: "2024-03-08 18:55:30", modifiedDatetime: "2024-03-08 18:55:30"),
        .init(id: 5, title: "지금 뭔상황이야?", text: "오우예", teamId: Team.SSG.id, teamName: Team.SSG.name, viewCount: 17, replyCount: 1, createdBy: User.MOCK_USER_SSG2.id, createdDatetime: "2024-03-08 18:56:00", modifiedDatetime: "2024-03-08 18:56:00"),
        .init(id: 6, title: "흠 불안하다", text: "ㅈㄱㄴ", teamId: Team.KW.id, teamName: Team.KW.name, viewCount: 7, replyCount: 0, createdBy: User.MOCK_USER_KW.id, createdDatetime: "2024-03-08 18:57:00", modifiedDatetime: "2024-03-08 18:57:00"),
    ]
}
