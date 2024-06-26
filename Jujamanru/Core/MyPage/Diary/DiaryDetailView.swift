//
//  DiaryDetailView.swift
//  Jujamanru
//
//  Created by 영현 on 6/18/24.
//

import SwiftUI
import Kingfisher

struct DiaryDetailView: View {
    @StateObject var viewModel: DiaryDetailViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Spacer()
                
                Text("\(viewModel.gameDate)")
                    .font(.headline)
                
                Spacer()

            }
            .padding(.horizontal)
            
            Divider()
            
            BannerView(viewModel: viewModel)
                .padding()
    
            
            Text(viewModel.matchTeams)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            Text(viewModel.gameDate)
                .font(.footnote)
                .foregroundColor(.gray)

            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .overlay(
                    ScrollView(showsIndicators: false) {
                        HStack {
                            Text(viewModel.text)
                            Spacer()
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal)
                )
                .padding()
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct BannerView: View {
    @StateObject var viewModel: DiaryDetailViewModel
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            if !viewModel.images.isEmpty {
                TabView(selection: $currentIndex) {
                    ForEach(0..<viewModel.images.count, id: \.self) { index in
                        KFImage(URL(string: "http://localhost:8080/images/\(viewModel.images[index])"))
                            .resizable()
                            .scaleEffect()
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
            }
        }
    }
}

#Preview {
    DiaryDetailView(viewModel: DiaryDetailViewModel(GameRecord.MOCK_GAME_RECORS[0]))
}
