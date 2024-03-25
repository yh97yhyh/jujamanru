//
//  LoginView.swift
//  Jujamanru
//
//  Created by 영현 on 3/24/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("주자만루 ⚾️")
                    .font(.title)
                    .fontWeight(.semibold)
                
                VStack {
                    TextField("아이디를 입력해주세요.", text: $viewModel.id)
                        .autocapitalization(.none)
                        .modifier(IGTextFieldModifier())
                        .autocorrectionDisabled()
                    
                    SecureField("비밀번호를 입력해주세요.", text: $viewModel.password)
                        .autocapitalization(.none)
                        .modifier(IGTextFieldModifier())
                        .autocorrectionDisabled()

                }
                .padding(.bottom)
                
                Button {
                    viewModel.login()
                } label: {
                    Text("로그인")
                }
                .buttonStyle(LoginButtonStyle(width: 350, height: 44))
                .padding(.bottom)
                
                Spacer()
                Divider()
                
                NavigationLink(destination: RegisterationView()) {
                    Text("계정이 없으신가요?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Text("회원가입")
                        .font(.footnote)
                        .foregroundColor(.black)
                }
                .padding(.vertical, 16)
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct LoginButtonStyle: ButtonStyle {
    let width: CGFloat?
    let height: CGFloat
    let isMaxWidth: Bool

    init(width: CGFloat? = nil, height: CGFloat = 32, isMaxWidth: Bool = false) {
        self.width = width
        self.height = height
        self.isMaxWidth = isMaxWidth
    }

    func makeBody(configuration: Configuration) -> some View {
        if isMaxWidth {
            configuration.label
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: width, height: height)
                .frame(maxWidth: .infinity)
                .background(.black)
                .foregroundColor(.white)
                .overlay(
                    Rectangle()
                        .stroke(.gray, lineWidth: 1)
                )
                .opacity(configuration.isPressed ? 0.8 : 1.0)
        } else {
            configuration.label
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: width, height: height)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 1)
                )
                .opacity(configuration.isPressed ? 0.8 : 1.0)
        }
    }
}

struct IGTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}


#Preview {
    LoginView()
}
