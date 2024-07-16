//
//  DiaryWriteView.swift
//  Jujamanru
//
//  Created by 영현 on 6/25/24.
//

import SwiftUI
import PhotosUI

struct DiaryWriteView: View {
    @StateObject var viewModel: DiaryWriteViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingImagePicker = false

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

            }
            .padding(.horizontal)
            
            Divider()
            
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
            
            DatePicker("날짜를 선택해 주세요.", selection: $viewModel.gameDate, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
            
            HStack {
                
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
    DiaryWriteView(viewModel: DiaryWriteViewModel())
}
