//
//  Common.swift
//  Jujamanru
//
//  Created by 영현 on 3/23/24.
//

import Foundation

struct Pageable: Codable {
    let sort: Sort
    let offset: Int
    let pageNumber: Int
    let pageSize: Int
    let paged: Bool
    let unpaged: Bool
}

struct Sort: Codable {
    let empty: Bool
    let sorted: Bool
    let unsorted: Bool
}
