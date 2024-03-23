//
//  ProfileHeaderView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @StateObject var viewModel = MyPageViewModel.shared

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
