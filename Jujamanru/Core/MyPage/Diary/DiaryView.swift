//
//  DiaryView.swift
//  Jujamanru
//
//  Created by 영현 on 6/18/24.
//

import SwiftUI

struct DiaryView: View {
    @EnvironmentObject var myPageviewModel: MyPageViewModel
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: DiaryViewModel
    
    var gridItems: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Spacer()
                
                Text("직관 일기")
                    .font(.headline)
                
                Spacer()

            }
            .padding(.horizontal)
            
            Divider()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(myPageviewModel.user.nickName)님은 현재 ")
                    + Text("\(viewModel.visitCount)회 ")
                        .foregroundColor(.red)
                    + Text("방문,")
                    Spacer()
                }
                HStack {
                    Text("\(viewModel.winRate) ")
                        .foregroundColor(.red)
                    + Text("입니다.")
                    Spacer()
                }
                    
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.top)
            .padding(.horizontal)
            
            Rectangle()
                .fill(Color(UIColor(hexCode: "#EFEFEF")))
                .frame(width: nil, height: 12)
                .padding(.bottom)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 8) {
                    ForEach(viewModel.records, id: \.self) { record in
                        DiaryCellView(viewModel: DiaryCellViewModel(record))
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DiaryView(viewModel: DiaryViewModel(User.MOCK_USER_SSG2))
        .environmentObject(MyPageViewModel(User.MOCK_USER_SSG2))
}
