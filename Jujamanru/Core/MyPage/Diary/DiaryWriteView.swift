//
//  DiaryWriteView.swift
//  Jujamanru
//
//  Created by 영현 on 6/25/24.
//

import SwiftUI
import PhotosUI

struct DiaryWriteView: View {
    @EnvironmentObject var teamViewModel: TeamViewModel
    @StateObject var viewModel: DiaryWriteViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingImagePicker = false
    @State private var showingOpponentTeamSelectionSheet = false
    @State var isShowingOpponentTeam = false

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
                
                Text("직관 일기 작성")
                    .font(.headline)
                
                Spacer()
                
                Button {
                    viewModel.writeGameRecord()
                    dismiss()
                } label: {
                    Text("등록")
                }
                .buttonStyle(PostWriteSubmitButtonStyle())

            }
            .padding(.horizontal)
            
            Divider()
            
            ImageBannerView(viewModel: viewModel, showingImagePicker: $showingImagePicker)
            
            DatePicker("날짜를 선택해 주세요.", selection: $viewModel.gameDate, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
            
            HStack {
                Button {
                    showingOpponentTeamSelectionSheet.toggle()
                } label: {
                    Text("상대팀을 선택해 주세요.")
                        .foregroundColor(.black)
                }.sheet(isPresented: $showingOpponentTeamSelectionSheet, content: {
                    OpponentTeamSelectView(viewModel: viewModel, isShowingOpponentTeam: $isShowingOpponentTeam)
                })
                
                Spacer()
                
                if isShowingOpponentTeam {
                    Text(viewModel.opponentTeam.name)
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                GameResultPicker(viewModel: viewModel)
            }
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .overlay(
                    ScrollView(showsIndicators: false) {
                        HStack {
                            TextEditor(text: $viewModel.text)
                                .autocapitalization(.none)
                                .padding(.horizontal)
                            Spacer()
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal)
                )
                .padding()
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct GameResultPicker: View {
    @StateObject var viewModel: DiaryWriteViewModel

    var body: some View {
        VStack {
            // Create a Picker
            Picker("Select Game Result", selection: $viewModel.gameResult) {
                // Iterate over all cases in the enum
                ForEach(GameResult.allCases) { result in
                    Text(result.rawValue.capitalized)
                        .tag(result)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}

struct OpponentTeamSelectView: View {
    @EnvironmentObject var teamViewModel: TeamViewModel
    @StateObject var viewModel: DiaryWriteViewModel
    @Binding var isShowingOpponentTeam: Bool
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List(teamViewModel.teams) { team in
            Button(action: {
                viewModel.opponentTeam = team
                isShowingOpponentTeam = true
                dismiss()
            }) {
                Text(team.name)
                    .font(.footnote)
                    .foregroundColor(.black)
            }
        }
    }
}

private struct ImageBannerView: View {
    @StateObject var viewModel: DiaryWriteViewModel
    @Binding var showingImagePicker: Bool
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            if viewModel.selectedImages.isEmpty {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .overlay(
                        VStack {
                            Spacer()
                            Button {
                                showingImagePicker = true
                            } label: {
                                VStack {
                                    Image(systemName: "photo.on.rectangle.angled")
                                    Text("사진 선택")
                                }
                                .foregroundColor(.black)
                            }
                            Spacer()
                        }
                    )
                    .padding()
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(selectedImages: $viewModel.selectedImages)
                    }
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(0..<viewModel.selectedImages.count, id: \.self) { index in
                        Image(uiImage: viewModel.selectedImages[index])
                            .resizable()
                            .scaleEffect()
                            .tag(index)
                    }
                    .padding()
                }
                .tabViewStyle(.page)
            }
            
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedImages.removeAll()

            let itemProviders = results.map { $0.itemProvider }

            for item in itemProviders {
                if item.canLoadObject(ofClass: UIImage.self) {
                    item.loadObject(ofClass: UIImage.self) { image, error in
                        DispatchQueue.main.async {
                            if let image = image as? UIImage {
                                self.parent.selectedImages.append(image)
                            }
                        }
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0  // 0 means no limit

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}

#Preview {
    DiaryWriteView(viewModel: DiaryWriteViewModel(userId: "ssg1"))
        .environmentObject(TeamViewModel())
}
