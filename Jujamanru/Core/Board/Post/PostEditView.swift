//
//  PostEditView.swift
//  Jujamanru
//
//  Created by 영현 on 3/26/24.
//

import SwiftUI

struct PostEditView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @EnvironmentObject var teamViewModel: TeamViewModel
    @StateObject var boardViewModel = BoardViewModel.shared
    @StateObject var postDetailViewModel: PostDetailViewModel
    @StateObject var viewModel: PostEditViewModel
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
                    viewModel.editPost { result in
                        switch result {
                        case .success(let postId):
//                            postDetailViewModel.fetchPost(postDetailViewModel.post.id, myPageViewModel.user.id)
//                            boardViewModel.fetchPosts()
                            print("succeed to edit post! \(postId)!")
                        case .failure(let error):
                            print("failed to edit post.. \(error.localizedDescription)")
                        }
                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        dismiss()
//                    }
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

#Preview {
    PostWriteView(viewModel: PostWriteViewModel(userId: "ssg1"))
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
        .environmentObject(TeamViewModel())
}

