//
//  Reply.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

struct Reply: Identifiable, Codable, Hashable {
    var id: Int
    var text: String
    var postId: Int
    var isPoster: Bool
    var createdBy: String
    var createdDatetime: String
    var modifiedDatetime: String
}

extension Reply {
    static let MOCK_REPLIES_POST0: [Reply] = [
        .init(id: 0, text: "아 제발 봐주세요", postId: 0, isPoster: true, createdBy: User.MOCK_USER_KIA.id, createdDatetime: "2024-03-08 18:50:00", modifiedDatetime: "2024-03-08 18:50:00"),
        .init(id: 1, text: "아 제발 봐주세요 22", postId: 0, isPoster: false, createdBy: User.MOCK_USER_KIA2.id, createdDatetime: "2024-03-08 18:50:30", modifiedDatetime: "2024-03-08 18:50:30"),
        .init(id: 2, text: "아 제발 봐주세요 33", postId: 0, isPoster: false, createdBy: User.MOCK_USER_KIA3.id, createdDatetime: "2024-03-08 18:51:00", modifiedDatetime: "2024-03-08 18:51:00"),
        .init(id: 3, text: "아 제발 봐주세요 44", postId: 0, isPoster: false, createdBy: User.MOCK_USER_KIA4.id, createdDatetime: "2024-03-08 18:51:00", modifiedDatetime: "2024-03-08 18:52:00"),
    ]
    static let MOCK_REPLIES: [Reply] = [
        .init(id: 0, text: "아 제발 봐주세요", postId: 0, isPoster: true, createdBy: User.MOCK_USER_KIA.id, createdDatetime: "2024-03-08 18:50:00", modifiedDatetime: "2024-03-08 18:50:00"),
        .init(id: 1, text: "아 제발 봐주세요 22", postId: 0, isPoster: false, createdBy: User.MOCK_USER_KIA2.id, createdDatetime: "2024-03-08 18:50:30", modifiedDatetime: "2024-03-08 18:50:30"),
        .init(id: 2, text: "아 제발 봐주세요 33", postId: 0, isPoster: false, createdBy: User.MOCK_USER_KIA3.id, createdDatetime: "2024-03-08 18:51:00", modifiedDatetime: "2024-03-08 18:51:00"),
        .init(id: 3, text: "아 제발 봐주세요 44", postId: 0, isPoster: false, createdBy: User.MOCK_USER_KIA4.id, createdDatetime: "2024-03-08 18:51:00", modifiedDatetime: "2024-03-08 18:52:00"),
        .init(id: 4, text: "상대의 본헤드 플레이래", postId: 5, isPoster: false, createdBy: User.MOCK_USER_KIA4.id, createdDatetime: "2024-03-08 18:57:00", modifiedDatetime: "2024-03-08 18:57:00"),
    ]
}
