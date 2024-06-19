//
//  DiaryViewModel.swift
//  Jujamanru
//
//  Created by 영현 on 6/18/24.
//

import Foundation

class DiaryViewModel: ObservableObject {
    @Published var records: [Record]
    
    init(records: [Record] = []) {
        self.records = records
    }
}
