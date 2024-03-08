//
//  HomeView.swift
//  Jujamanru
//
//  Created by 영현 on 3/8/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack {
                Text("주자만루")
                    .font(.headline)
                Spacer()
                
                NavigationLink(destination: Text("")) {
                    Image(systemName: "square.and.pencil")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }

            }
            .padding(.horizontal)
            .padding(.bottom)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("전체 인기글 🔥")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .padding()
                
                Divider()
                
                VStack {
                    HStack {
                        Text("우리팀 인기글 🏟️")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .padding()
                
                Divider()
                
                VStack {
                    HStack {
                        Text("공지 ")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .padding()
            }
            
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
