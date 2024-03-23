//
//  Post.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

struct Post: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let text: String
    let teamId: Int?
    let teamName: String?
    let viewCount: Int
    let replyCount: Int
    let createdBy: String
    let modifiedDatetime: String
    let isUpdated: Bool
    let isNotice: Bool
    let mustRead: Bool
    let replies: [Reply]
    let timeView: String
}

//struct Post: Identifiable, Codable, Hashable {
//    var id: Int
//    var title: String
//    var text: String
//    var teamId: Int
//    var teamName: String
//    var viewCount: Int
//    var replyCount: Int
//    var createdBy: String
//    var createdDatetime: String
//    var modifiedDatetime: String
//}

extension Post {
    static let MOCK_POSTS: [Post] = [
        Post(id: 1, title: "아 제발 봐주세요", text: "아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 ", teamId: Team.MOCK_TEAMS[5].id, teamName: Team.MOCK_TEAMS[5].name, viewCount: 36, replyCount: 4, createdBy: User.MOCK_USER_KIA.id, modifiedDatetime: "2024-03-08 18:49:00", isUpdated: false, isNotice: false, mustRead: false, replies: [], timeView: ""),
        Post(id: 2, title: "오 오늘 좀 잘한다", text: "선발 전원 홈런이라니", teamId: Team.MOCK_TEAMS[0].id, teamName: Team.MOCK_TEAMS[0].name, viewCount: 33, replyCount: 0, createdBy: User.MOCK_USER_LG.id, modifiedDatetime: "2024-03-08 18:52:00", isUpdated: false, isNotice: false, mustRead: false, replies: [], timeView: ""),
        Post(id: 3, title: "헉 대박", text: "수비 ㅁㅊ", teamId: Team.MOCK_TEAMS[8].id, teamName: Team.MOCK_TEAMS[8].name, viewCount: 31, replyCount: 0, createdBy: User.MOCK_USER_HH.id, modifiedDatetime: "2024-03-08 18:53:00", isUpdated: false, isNotice: false, mustRead: false, replies: [], timeView: ""),
        Post(id: 4, title: "아니 이걸;;", text: ";;;;뭔데", teamId: Team.MOCK_TEAMS[1].id, teamName: Team.MOCK_TEAMS[1].name, viewCount: 19, replyCount: 0, createdBy: User.MOCK_USER_KT.id, modifiedDatetime: "2024-03-08 18:55:00", isUpdated: false, isNotice: false, mustRead: false, replies: [], timeView: ""),
        Post(id: 5, title: "와 이걸 사네 굿", text: "오우예", teamId: Team.MOCK_TEAMS[2].id, teamName: Team.MOCK_TEAMS[2].name, viewCount: 17, replyCount: 0, createdBy: User.MOCK_USER_SSG.id, modifiedDatetime: "2024-03-08 18:55:30", isUpdated: false, isNotice: false, mustRead: false, replies: [], timeView: ""),
        Post(id: 6, title: "지금 뭔상황이야?", text: "오우예", teamId: Team.MOCK_TEAMS[2].id, teamName: Team.MOCK_TEAMS[2].name, viewCount: 17, replyCount: 1, createdBy: User.MOCK_USER_SSG2.id, modifiedDatetime: "2024-03-08 18:56:00", isUpdated: false, isNotice: false, mustRead: false, replies: [], timeView: ""),
        Post(id: 7, title: "흠 불안하다", text: "ㅈㄱㄴ", teamId: Team.MOCK_TEAMS[9].id, teamName: Team.MOCK_TEAMS[9].name, viewCount: 7, replyCount: 0, createdBy: User.MOCK_USER_KW.id, modifiedDatetime: "2024-03-08 18:57:00", isUpdated: false, isNotice: false, mustRead: false, replies: [], timeView: ""),
    ]
    
    static let MOCK_NOTICES: [Post] = [
        Post(id: 0, title: "주자만루 기본 공지!!", text: "서로 비방하지 맙시다~~~", teamId: nil, teamName: nil, viewCount: 921, replyCount: 0, createdBy: User.MOCK_ADMIN.id, modifiedDatetime: "2024-03-08", isUpdated: true, isNotice: true, mustRead: true, replies: [], timeView: "")
    ]
    
//    static let MOCK_POSTS: [Post] = [
//        .init(id: 0, title: "아 제발 봐주세요", text: "아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 아 제발 봐주세요 ", teamId: Team.KIA.id, teamName: Team.KIA.name, viewCount: 36, replyCount: 4, createdBy: User.MOCK_USER_KIA.id, createdDatetime: "2024-03-08 18:49:00", modifiedDatetime: "2024-03-08 18:49:00"),
//        .init(id: 1, title: "오 오늘 좀 잘한다", text: "선발 전원 홈런이라니", teamId: Team.LG.id, teamName: Team.LG.name, viewCount: 33, replyCount: 0, createdBy: User.MOCK_USER_LG.id, createdDatetime: "2024-03-08 18:52:00", modifiedDatetime: "2024-03-08 18:52:00"),
//        .init(id: 2, title: "헉 대박", text: "수비 ㅁㅊ", teamId: Team.HH.id, teamName: Team.HH.name, viewCount: 31, replyCount: 0, createdBy: User.MOCK_USER_HH.id, createdDatetime: "2024-03-08 18:53:00", modifiedDatetime: "2024-03-08 18:53:00"),
//        .init(id: 3, title: "아니 이걸;;", text: ";;;;뭔데", teamId: Team.KT.id, teamName: Team.KT.name, viewCount: 19, replyCount: 0, createdBy: User.MOCK_USER_KT.id, createdDatetime: "2024-03-08 18:55:00", modifiedDatetime: "2024-03-08 18:55:00"),
//        .init(id: 4, title: "와 이걸 사네 굿", text: "오우예", teamId: Team.SSG.id, teamName: Team.SSG.name, viewCount: 17, replyCount: 0, createdBy: User.MOCK_USER_SSG.id, createdDatetime: "2024-03-08 18:55:30", modifiedDatetime: "2024-03-08 18:55:30"),
//        .init(id: 5, title: "지금 뭔상황이야?", text: "오우예", teamId: Team.SSG.id, teamName: Team.SSG.name, viewCount: 17, replyCount: 1, createdBy: User.MOCK_USER_SSG2.id, createdDatetime: "2024-03-08 18:56:00", modifiedDatetime: "2024-03-08 18:56:00"),
//        .init(id: 6, title: "흠 불안하다", text: "ㅈㄱㄴ", teamId: Team.KW.id, teamName: Team.KW.name, viewCount: 7, replyCount: 0, createdBy: User.MOCK_USER_KW.id, createdDatetime: "2024-03-08 18:57:00", modifiedDatetime: "2024-03-08 18:57:00"),
//    ]
}

struct PostsResponse: Codable {
    let content: [Post]
    let pageable: Pageable
    let last: Bool
    let totalPages: Int
    let totalElements: Int
    let size: Int
    let number: Int
    let sort: Sort
    let first: Bool
    let numberOfElements: Int
    let empty: Bool
}
