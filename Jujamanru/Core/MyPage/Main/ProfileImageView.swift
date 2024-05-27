//
//  ProfileImageView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct ProfileImageView: View {
    @EnvironmentObject var viewModel: MyPageViewModel

    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .foregroundColor(Color(.systemGray4))
    }
}

#Preview {
    ProfileImageView()
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
}
