//
//  Bundle+Extensions.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import Foundation

extension Bundle {
    var apiKey: String? {
        return infoDictionary?["API_KEY"] as? String
    }
}
