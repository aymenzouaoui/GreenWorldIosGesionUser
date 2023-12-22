//
//  GestionUserEditProfil.swift
//  GreenWorld
//
//  Created by zouaoui on 1/12/2023.
//

import SwiftUI

struct UserUpdateView: View {
    @State private var selectedImage: Image?
    @State private var showImagePicker = false
    @State private var selectedImageURL: URL?
    
    var body: some View {
        VStack {
            Button(action: {
                showImagePicker = true
            }) {
                Text("Select Image")
            }
            
            if let image = selectedImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            }
            
            Button(action: {
                uploadImage()
                updateUserp()
            }) {
                Text("Upload Image")
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(selectedImage: $selectedImage, selectedImageURL: $selectedImageURL)
        }
    }
    
    private func uploadImage() {
        // Implement the logic to upload the image to Cloudinary
        guard let imageURL = selectedImageURL else {
            return
        }
        
        // Replace this code with the actual logic to upload the image to Cloudinary
        // You can use a library like Alamofire or URLSession for network requests
        
        // Example using URLSession
        guard let imageData = try? Data(contentsOf: imageURL) else {
            return
        }
        
        let url = URL(string: "https://api.cloudinary.com/v1_1/your_cloud_name/image/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.uploadTask(with: request, from: imageData) { data, response, error in
            // Handle the response from Cloudinary
        }.resume()
    }
    
    private func updateUserp() {
        // Implement the logic to update the user
        
        // Example code to update the user using a network request
        guard let userURL = URL(string: "https://your_api_url.com/updateUser") else {
            return
        }
        
        // Prepare the request body with the necessary parameters
        let parameters: [String: Any] = [
            "userId": "123",
            "email": "example@example.com",
            // Add other parameters as needed
        ]
        
        var request = URLRequest(url: userURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response from the server
        }.resume()
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: Image?
    @Binding var selectedImageURL: URL?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: image)
                
                if let imageURL = info[.imageURL] as? URL {
                    parent.selectedImageURL = imageURL
                }
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct UserUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UserUpdateView()
    }
}
