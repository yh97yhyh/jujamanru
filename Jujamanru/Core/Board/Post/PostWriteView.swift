//
//  PostWriteView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct PostWriteView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @EnvironmentObject var teamViewModel: TeamViewModel
    @StateObject var boardViewModel = BoardViewModel.shared
    @StateObject var viewModel: PostWriteViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Spacer()
                
                Button {
                    viewModel.writePost { result in
                        switch result {
                        case .success(let postId):
                            boardViewModel.fetchPosts()
                            print("succeed to write post! \(postId)!")
                        case .failure(let error):
                            print("failed to write post.. \(error.localizedDescription)")
                        }
                    }
                    dismiss()
                } label: {
                    Text("등록")
                }
                .buttonStyle(PostWriteSubmitButtonStyle())
                
            }
            .padding(.horizontal)
            //            .padding(.bottom)
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Picker("Team", selection: $viewModel.selectedTeam) {
                        Text("선택X ").tag(0)
                        ForEach(teamViewModel.teams, id: \.self) { team in
                            Text("\(team.name) ").tag(team.id)
                        }
                    }
                    .accentColor(.black)
                    
                    Spacer()
                }
                
                TextField("제목을 입력해주세요.", text: $viewModel.title)
                    .font(.title3)
                    .autocapitalization(.none)
                    .padding(.horizontal)
            }
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                TextEditor(text: $viewModel.text)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                
                
            }
            
//            .pickerStyle(SegmentedPickerStyle())
//            .padding(.horizontal)
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct PostWriteSubmitButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.horizontal, 4)
            .frame(width: 48, height: 32)
            .background(.white)
            .foregroundColor(.black)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.gray, lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

#Preview {
    PostWriteView(viewModel: PostWriteViewModel(userId: "ssg1"))
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
        .environmentObject(TeamViewModel())
}
