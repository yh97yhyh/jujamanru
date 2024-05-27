//
//  TeamSelectView.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import SwiftUI

struct TeamSelectView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @EnvironmentObject var teamViewModel: TeamViewModel
    @State var selectedTeam: Team?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List(teamViewModel.teams) { team in
            Button(action: {
                selectedTeam = team
                myPageViewModel.updateTeam(team.id)
                dismiss()
            }) {
                Text(team.name)
                    .font(.footnote)
                    .foregroundColor(.black)
            }
        }
    }
}


#Preview {
    TeamSelectView()
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
        .environmentObject(TeamViewModel())
}
