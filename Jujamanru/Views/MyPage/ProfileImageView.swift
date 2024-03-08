//
//  ProfileImageView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct ProfileImageView: View {
    @StateObject var viewModel = MyPageViewModel.shared

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
}
