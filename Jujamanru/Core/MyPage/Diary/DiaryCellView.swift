//
//  DiaryCellView.swift
//  Jujamanru
//
//  Created by 영현 on 6/19/24.
//

import SwiftUI

struct DiaryCellView: View {
    @StateObject var viewModel: DiaryCellViewModel
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary, lineWidth: 1)
                .frame(width: 100, height: 100)
                .overlay(
                    Text(viewModel.gameResult)
                        .font(.largeTitle)
                )
            
            Text(viewModel.gameDate)
                .font(.footnote)
                .foregroundColor(.gray)
            Text(viewModel.matchTeams)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    DiaryCellView(viewModel: DiaryCellViewModel(GameRecord.MOCK_GAME_RECORS[0]))
}
