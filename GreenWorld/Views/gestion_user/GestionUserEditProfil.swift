import SwiftUI

struct GestionUserEditProfil: View {
    @State private var selectedImage: Image?
    @State private var showImagePicker = false
    @State private var selectedImageURL: URL?
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var userImage: Image? = nil

    func loadImageFromURL() {
        guard let imageURLString = userViewModel.user?.imageRes,
              let imageURL = URL(string: imageURLString) else {
            return
        }

        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            DispatchQueue.main.async {
                if let uiImage = UIImage(data: data) {
                    self.userImage = Image(uiImage: uiImage)
                } else {
                    self.userImage = nil
                }
            }
        }.resume()
    }

    @StateObject private var userViewModel = UserViewModel()
    var body: some View {
        VStack {
            Button(action: {
                showImagePicker = true
            }) {
                ZStack {
                  

                    if let imageURL = URL(string: userViewModel.user?.imageRes ?? "") {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                // Image non chargée
                                ProgressView()
                            case .success(let image):
                                // Image chargée avec succès
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Ellipse()) // Clip the image into an ellipse
                                    .frame(width: 200, height: 200) // Adjust the size of the clipped image
                                    .overlay(Ellipse().stroke(Color.green, lineWidth: 3)) // Add a stroke to the clipped image
                                    .shadow(color: Color(red: 0.40, green: 0.40, blue: 0.40, opacity: 0.15), radius: 10, y: 4)
                                    .position(x: 180, y: 200)
                            case .failure(let error):
                                // Erreur lors du chargement de l'image
                                Text("Erreur de chargement de l'image")
                            @unknown default:
                                // Cas par défaut
                                EmptyView()
                            }
                        }
                    } else {
                        // URL de l'image invalide
                        Text("URL de l'image invalide")
                    }
                }

                .padding()
            }
            
            
            Button(action: {
               
                
            }) {
                Text("Save Image ")
            }
            
            TextField(userViewModel.user?.email ?? "", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.green, lineWidth: 2)
                                    .padding(5)
                            )
                            .overlay(
                                HStack {
                                    Spacer().frame(width: 7) // Espacement supplémentaire à gauche de l'icône
                                    Image(systemName: "envelope")
                                        .foregroundColor(Color(red: 0.13, green: 0.61, blue: 0.49))
                                        .frame(width: 20, height: 20)
                                    Spacer()
                                }
                            )
                        
                        TextField(userViewModel.user?.userName ?? "", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.green, lineWidth: 2)
                                    .padding(5)
                            )
                            .overlay(
                                HStack {
                                    Spacer().frame(width: 7) // Espacement supplémentaire à gauche de l'icône
                                    Image(systemName: "person")
                                        .foregroundColor(Color(red: 0.13, green: 0.61, blue: 0.49))
                                        .frame(width: 20, height: 20)
                                    Spacer()
                                }
                            )
                        
                        TextField(userViewModel.user?.numTel ?? "", text: $phoneNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.green, lineWidth: 2)
                                    .padding(5)
                            )
                            .overlay(
                                HStack {
                                    Spacer().frame(width: 7) // Espacement supplémentaire à gauche de l'icône
                                    Image(systemName: "phone")
                                        .foregroundColor(Color(red: 0.13, green: 0.61, blue: 0.49))
                                        .frame(width: 20, height: 20)
                                    Spacer()
                                }
                            )
                        
            
            Button(action: {
                
            }) {
                Text("Update Profile")
                    .font(Font.custom("Inter", size: 20).weight(.bold))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                    .frame(width:200, height: 51)
                    .background(Color(red: 0.13, green: 0.61, blue: 0.49))
                    .cornerRadius(12)

            }
        } .onAppear {
            loadImageFromURL()
            userViewModel.getUser()
            print(userViewModel.getUser())
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(selectedImage: $selectedImage, selectedImageURL: $selectedImageURL, userImage: $userImage)
        }
    }
    
    private func uploadImage() {
        // Implémentez ici votre logique pour télécharger l'image sélectionnée
        // Vous pouvez utiliser la propriété selectedImageURL pour accéder à l'URL de l'image sélectionnée
        // Par exemple :
        if let imageURL = selectedImageURL {
            // Effectuez les opérations nécessaires pour télécharger l'image à partir de l'URL
            // ...
            
            // Mettez à jour l'image de l'utilisateur avec la nouvelle image téléchargée
            userImage = selectedImage
        }
    }
    
  
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: Image?
    @Binding var selectedImageURL: URL?
    @Binding var userImage: Image?
    
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
                
                parent.userImage = parent.selectedImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct UserUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        GestionUserEditProfil()
    }
}
/*import SwiftUI

struct GestionUserEditProfil: View {
    @State private var selectedImage: Image?
    @State private var showImagePicker = false
    @State private var selectedImageURL: URL?
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var userImage: Image? = nil
    @State private var buttonScale: CGFloat = 1.0 // Added for button animation
    @State private var isShowingDialog = false // Added for showing dialog
    @StateObject private var userViewModel = UserViewModel()

    func loadImageFromURL() {
        guard let imageURLString = userViewModel.user?.imageRes,
              let imageURL = URL(string: imageURLString) else {
            return
        }

        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            DispatchQueue.main.async {
                if let uiImage = UIImage(data: data) {
                    self.userImage = Image(uiImage: uiImage)
                } else {
                    self.userImage = nil
                }
            }
        }.resume()
    }

    var body: some View {
        VStack {
            Button(action: {
                showImagePicker = true
            }) {
                ZStack {
                    if let imageURL = URL(string: userViewModel.user?.imageRes ?? "") {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Ellipse())
                                    .frame(width: 200, height: 200)
                                    .overlay(Ellipse().stroke(Color.green, lineWidth: 3))
                                    .shadow(color: Color(red: 0.40, green: 0.40, blue: 0.40, opacity: 0.15), radius: 10, y: 4)
                                    .position(x: 180, y: 200)
                            case .failure(let error):
                                Text("Error loading image")
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Text("Invalid image URL")
                    }
                }
                .padding()
                .scaleEffect(buttonScale)
            }

            Button(action: {
                showConfirmationDialog()
            }) {
                Text("Update Profile")
                    .customizeButton()
                    .scaleEffect(buttonScale)
            }
            .onTapGesture {
                withAnimation {
                    buttonScale = 0.8
                }

                withAnimation {
                    buttonScale = 1.0
                }
            }
            .alert(isPresented: $isShowingDialog) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text("Are you sure you want to update your profile?"),
                    primaryButton: .default(Text("Yes")) {
                        updateProfile()
                    },
                    secondaryButton: .cancel(Text("No"))
                )
            }

            TextField(userViewModel.user?.email ?? "", text: $email)
                .customizeTextField()

            TextField(userViewModel.user?.userName ?? "", text: $username)
                .customizeTextField()

            TextField(userViewModel.user?.numTel ?? "", text: $phoneNumber)
                .customizeTextField()
        }
        .onAppear {
            loadImageFromURL()
            userViewModel.getUser()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(selectedImage: $selectedImage, selectedImageURL: $selectedImageURL, userImage: $userImage)
        }
    }

    func showConfirmationDialog() {
        isShowingDialog = true
    }

    func updateProfile() {
        // Add your logic for updating the profile here
    }
}

extension View {
    func customizeTextField() -> some View {
        self
            .foregroundColor(.gray)
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.green, lineWidth: 2)
                    .padding(5)
            )
            .overlay(
                HStack {
                    Spacer().frame(width: 7)
                    Image(systemName: "envelope")
                        .foregroundColor(Color(red: 0.13, green: 0.61, blue: 0.49))
                        .frame(width: 20, height: 20)
                    Spacer()
                }
            )
    }

    func customizeButton() -> some View {
        self
            .font(Font.custom("Inter", size: 20).weight(.bold))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .frame(width: 200, height: 51)
            .background(Color(red: 0.13, green: 0.61, blue: 0.49))
            .cornerRadius(12)
    }
}
*/

