//
//  ImagePicker.swift
//  CashApp
//
//  Created by Samuel Toh on 6/18/20.
//  Copyright © 2020 Samuel Toh. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}




struct ImagePickerView: View {
    @State var imagePicker = false
    @EnvironmentObject var userData: UserData
    @State var imageURL = ""

    var body: some View {

        NavigationView {
            Button(action: {
                self.imagePicker.toggle()
            }) {
                if userData.image != nil {
                    Image(uiImage: userData.image!)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        
                    
                } else {
                    Loader()
//                    Image(systemName: "plus")
//                        .font(.system(size: 24, weight: .bold))
                }
            }
        }.sheet(isPresented: $imagePicker) {
            ImagePicker().environmentObject(self.userData)
        }
        
//        .onAppear(perform: downloadImageFromFirebase)
    }
    
    func downloadImageFromFirebase() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
                
        let storage = Storage.storage().reference()
        
        let file_name = "/users/" + userID + "/profilePicture.png"
        
        storage.child(file_name).getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if error != nil {
                print ((error?.localizedDescription)!)
                return
            } else {
                self.userData.image = UIImage(data: data!)
            }
        }
    }
}

struct Loader : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
}

struct ImagePickerViewController: UIViewControllerRepresentable {

    @Binding var image: UIImage?
    @Binding var presentationMode: PresentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerViewController>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerViewController>) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePickerViewController

        init(_ parent: ImagePickerViewController) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                parent.image = editedImage.withRenderingMode(.alwaysOriginal)
            } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.image = originalImage.withRenderingMode(.alwaysOriginal)
            }

            uploadImage(image: parent.image!)
            parent.presentationMode.dismiss()
            picker.dismiss(animated: true, completion: nil)
        }
        
        
        func uploadImage(image: UIImage) {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let storage = Storage.storage().reference()
            
            let file_name = "/users/" + userID + "/profilePicture.png"
            
            storage.child(file_name).putData(image.jpegData(compressionQuality: 0.42)!, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print ((error?.localizedDescription)!)
                    return
                }
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.dismiss()
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

struct ImagePicker : View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ImagePickerViewController(image: $userData.image, presentationMode: presentationMode)
    }
}
