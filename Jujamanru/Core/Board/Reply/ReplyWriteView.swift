//
//  ReplyWriteView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct ReplyWriteView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: ReplyWriteViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("댓글 작성")
                    .font(.subheadline)
                Spacer()
            }
            
            HStack {
                TextField("댓글을 입력하세요...", text: $viewModel.text)
                    .autocapitalization(.none)
                    .modifier(ReplyWriteTextFieldModifier())
                
                Button {
                    viewModel.writeReply { result in
                        switch result {
                        case .success(let replyId):
                            print("succeed to write reply! \(replyId)!")
                        case .failure(let error):
                            print("failed to write reply.. \(error.localizedDescription)")
                        }
                    }
                    dismiss()
                } label: {
                    Text("등록")
                }
                .buttonStyle(ReplyWriteSubmitButtonStyle())
            }
        }
        .padding(.horizontal)
    }
}

struct ReplyWriteSubmitButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.horizontal, 4)
            .frame(height: 32)
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

struct ReplyWriteTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .frame(height: 32)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.gray, lineWidth: 1)
            )
//            .background(Color(.systemGray6))
//            .cornerRadius(10)
//            .padding(.horizontal, 24)
    }
}

#Preview {
    ReplyWriteView(viewModel: ReplyWriteViewModel(postId: 4, userId: "ssg1"))
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
}
