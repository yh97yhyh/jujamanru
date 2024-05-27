//
//  RegisterationView.swift
//  Jujamanru
//
//  Created by 영현 on 3/26/24.
//

import SwiftUI

struct RegisterationView: View {
    @StateObject var viewModel = RegisterationViewModel.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Text("아이디를 입력해 주세요.")
                .padding(.top)
                .padding(.horizontal, 30)
                .frame(alignment: .leading)
            
            TextField("id", text: $viewModel.id)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.bottom)
                .autocorrectionDisabled()
            
            Text("비밀번호를 입력해 주세요.")
                .padding(.top)
                .padding(.horizontal, 30)
                .frame(alignment: .leading)
            
            SecureField("password", text: $viewModel.password)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.bottom)
                .autocorrectionDisabled()
            
            Text("닉네임을 입력해 주세요.")
                .padding(.top)
                .padding(.horizontal, 30)
                .frame(alignment: .leading)
            
            TextField("Nickname", text: $viewModel.nickname)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.bottom)
                .autocorrectionDisabled()
            
            HStack {
                Spacer()
                Button {
                    viewModel.createUser()
                } label: {
                    Text("회원가입 완료")
                }
                .buttonStyle(LoginButtonStyle(width: 350, height: 44))
                .padding(.vertical)
                Spacer()
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterationView()
}
