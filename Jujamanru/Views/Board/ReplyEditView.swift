//
//  ReplyEditView.swift
//  Jujamanru
//
//  Created by 영현 on 3/26/24.
//

import SwiftUI

struct ReplyEditView: View {
    @EnvironmentObject var myPageViewModel: MyPageViewModel
    @StateObject var viewModel: ReplyEditViewModel
    @Environment(\.dismiss) private var dismiss
    
//    init(reply: Reply) {
//        self.viewModel = ReplyEditViewModel(reply)
//    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("댓글 수정")
                    .font(.subheadline)
                Spacer()
            }
            
            HStack {
                TextField("댓글을 입력하세요...", text: $viewModel.text)
                    .autocapitalization(.none)
                    .modifier(ReplyWriteTextFieldModifier())
                Button {
                    viewModel.editReply { result in
                        switch result {
                        case .success(let replyId):
                            print("succeed to edit reply! \(replyId)!")
                        case .failure(let error):
                            print("failed to edit reply.. \(error.localizedDescription)")
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
        .onAppear {
//            print(viewModel.reply)
        }
    }
}

#Preview {
    ReplyEditView(viewModel: ReplyEditViewModel(Reply.MOCK_REPLIES[0]))
//    ReplyEditView(reply: Reply.MOCK_REPLIES[0])
}
