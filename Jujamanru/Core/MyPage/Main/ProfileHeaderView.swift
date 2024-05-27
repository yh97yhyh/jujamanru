//
//  ProfileHeaderView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @EnvironmentObject var teamViewModel: TeamViewModel
    @EnvironmentObject var viewModel: MyPageViewModel
    @State private var isTeamSelectionSheetPresented = false

    var body: some View {
        VStack {
            HStack {
                ProfileImageView()
                
                VStack(alignment: .leading) {
                    Text("\(viewModel.user.nickName) 님")
                        .font(.subheadline)
                        .fontWeight(.semibold)
//                        .padding(.bottom, 2)
                    Text("아이디 : \(viewModel.user.id)")
                        .font(.footnote)
//                        .padding(.bottom, 2)
                    
                    HStack {
                        Text(viewModel.user.team?.name ?? "팀을 선택해주세요!")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                        
                        Button {
                            isTeamSelectionSheetPresented.toggle()
                        } label: {
                            Text("팀변경")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .sheet(isPresented: $isTeamSelectionSheetPresented) {
                            TeamSelectView()
                        }
                    }
//                        .onTapGesture {
//                                        isTeamSelectionSheetPresented.toggle()
//                                    }
//                        .sheet(isPresented: $isTeamSelectionSheetPresented) {
//                            TeamSelectView()
//                        }
                    
//                    Picker("Team", selection: $viewModel.myTeam) {
//                        ForEach(teamViewModel.teams, id: \.self) { team in
//                            Text("\(team.name) ").tag(team.id)
//                        }
//                    }
//                    .accentColor(.blue)
                }
                .padding(.leading, 32)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileHeaderView()
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
        .environmentObject(TeamViewModel())
}
