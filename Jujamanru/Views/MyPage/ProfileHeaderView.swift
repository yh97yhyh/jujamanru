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
                    Text(viewModel.user.id)
                        .font(.footnote)
                    Text(viewModel.user.team?.name ?? "")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .onTapGesture {
                                        isTeamSelectionSheetPresented.toggle()
                                    }
                        .sheet(isPresented: $isTeamSelectionSheetPresented) {
                            TeamSelectView()
                        }
                    
//                    Picker("Team", selection: $viewModel.myTeam) {
//                        Text("팀 없음 ").tag(0)
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
}
