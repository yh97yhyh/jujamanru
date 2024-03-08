//
//  CategoryView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct BoardView: View {
    @StateObject var viewModel = BoardViewModel.shared
    @State private var selectedTeam: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("주자만루")
                    .font(.headline)
                Spacer()
                
                NavigationLink(destination: Text("")) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }

            }
            .padding(.horizontal)
            
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        HStack(spacing: 20) {
                            Button("전체") {
                                withAnimation {
                                    selectedTeam = 0
                                    scrollProxy.scrollTo(0, anchor: .center)
                                }
                            }
                            .buttonStyle(TeamButtonStyle(isSelected: selectedTeam == 0))
                            .id(0)
                            ForEach(viewModel.teams, id: \.self) { team in
                                Button(team.name) {
                                    withAnimation {
                                        selectedTeam = team.id
                                        scrollProxy.scrollTo(selectedTeam, anchor: .center)
                                    }
                                }
                                .buttonStyle(TeamButtonStyle(isSelected: selectedTeam == team.id))
                                .id(team.id)
                            }
                        }
                        
                    }
                    .padding()
                }
                .onChange(of: selectedTeam) { newTeam in
                    let scrollToCategoryID = newTeam == 0 ? 0 : viewModel.teams[newTeam - 1].id
                    scrollProxy.scrollTo(scrollToCategoryID, anchor: .center)
                }
            }
            
            Divider()
                .padding(.bottom, 4)
            
            TabView(selection: $selectedTeam) {
                ForEach(0...viewModel.teams.count, id: \.self) { index in
                    if index == 0 {
                        PostsView(selectedTeam: $selectedTeam)
                            .tag(0)
                    } else {
                        PostsView(selectedTeam: $selectedTeam)
                            .tag(viewModel.teams[index-1].id)
                    }
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct FilterButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .cornerRadius(8)
    }
}

struct TeamButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelected ? .black : .gray)
            .cornerRadius(8)
    }
}

#Preview {
    BoardView()
}
