//
//  ImagePicker.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/24/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth


struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                let data = uiImage.jpegData(compressionQuality: 0.8)!
                let userImageId = Auth.auth().currentUser!.uid
                let uploadRef = Storage.storage().reference(withPath: "profileImage/\(userImageId).jpg")
                let metadata = StorageMetadata.init()
                metadata.contentType = "image/jpeg"
                uploadRef.putData(data, metadata: metadata){(data, error) in
                    if error != nil {
                        print("An error has occured: \(String(describing: error?.localizedDescription))")
                        return
                    } else {
                        print("image detail: \(String(describing: data))")
                    }
                }
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}
