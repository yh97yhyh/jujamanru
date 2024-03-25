//
//  CategoryView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @EnvironmentObject var teamViewModel: TeamViewModel
    @StateObject var viewModel = BoardViewModel.shared
    @State private var isInit = true
    
    var body: some View {
        VStack {
            HStack {
                Text("주자만루")
                    .font(.headline)
                Spacer()
                
                NavigationLink(destination: PostWriteView(viewModel: PostWriteViewModel(userId: myPageViewModel.user.id))) {
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
                                    viewModel.selectedTeam = 0
                                    scrollProxy.scrollTo(0, anchor: .center)
                                }
                            }
                            .buttonStyle(TeamButtonStyle(isSelected: viewModel.selectedTeam == 0))
                            .id(0)
                            ForEach(teamViewModel.teams, id: \.self) { team in
                                Button(team.name) {
                                    withAnimation {
                                        viewModel.selectedTeam = team.id
                                        scrollProxy.scrollTo(viewModel.selectedTeam, anchor: .center)
                                    }
                                }
                                .buttonStyle(TeamButtonStyle(isSelected: viewModel.selectedTeam == team.id))
                                .id(team.id)
                            }
                        }
                        
                    }
                    .padding()
                }
                .onChange(of: viewModel.selectedTeam) { newTeam in
                    let scrollToCategoryID = newTeam == 0 ? 0 : teamViewModel.teams[newTeam - 1].id
                    scrollProxy.scrollTo(scrollToCategoryID, anchor: .center)
                }
            }
            
            Divider()
                .padding(.bottom, 4)
            
            TabView(selection: $viewModel.selectedTeam) {
                ForEach(0...teamViewModel.teams.count, id: \.self) { index in
                    if index == 0 {
                        PostsView(selectedTeam: $viewModel.selectedTeam)
                            .tag(0)
                    } else {
                        PostsView(selectedTeam: $viewModel.selectedTeam)
                            .tag(teamViewModel.teams[index-1].id)
                    }
                }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if !isInit {
                viewModel.fetchPosts()
            }
            isInit = false
        }
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
