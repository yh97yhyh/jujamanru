//
//  PostWriteView.swift
//  Jujamanru
//
//  Created by 영현 on 3/9/24.
//

import SwiftUI

struct PostWriteView: View {
    @Environment(\.dismiss) private var dismiss
    @State var team: Team = Team.LG
    @State var title: String = ""
    @State var text: String = ""
    
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
                    Picker("Team", selection: $team) {
                        ForEach(Team.TEAMS, id: \.self) { team in
                            Text(team.name).tag(team)
                        }
                    }
                    .accentColor(.black)
                    
                    Spacer()
                }
                
                TextField("제목을 입력해주세요.", text: $text)
                    .font(.title3)
                    .autocapitalization(.none)
                    .padding(.horizontal)
            }
            
            Divider()
            
            ScrollView(showsIndicators: false) {
                TextField("내용을 입력해주세요...", text: $text)
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
    PostWriteView()
}
