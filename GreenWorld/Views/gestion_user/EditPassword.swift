//
//  EditPassword.swift
//  GreenWorld
//
//  Created by arafetksiksi on 8/12/2023.
//

import SwiftUI

struct EditPassword: View {
    @StateObject private var userViewModel = UserViewModel()
    @State private var userId: String = ""
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmNewPassword: String = ""

    @State private var isPasswordVisible = false
    @State private var showAlert = false
    @State private var alertMessage = ""
      @Environment(\.presentationMode) var presentationMode
    var body: some View {
Spacer(minLength: 120)
        
        ZStack {LinearGradient(gradient: Gradient(colors: [Color.white, Color.green]), startPoint: .bottomLeading, endPoint: .trailing)
            if let imageURL = URL(string: userViewModel.user?.imageRes ?? "") {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        // Image non chargée
                        ProgressView()
                    case .success(let image):
                        // Image chargée avec succès
                        image
                          
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle()) // Appliquer la forme de cercle à l'image
                            .frame(width: 100, height: 100) // Ajuster la taille du cercle
                            .overlay(Circle().stroke(Color.green, lineWidth: 3)) // Ajouter un contour au cercle
                            .position(x: 379, y: 120)
                       
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .padding()
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
        .padding(.bottom, 160)
        
        HStack {
            
            
            
            
            Image(systemName: "lock")
                .foregroundColor(.gray)
                .padding(.leading, 8)
            if isPasswordVisible {
                TextField("", text: $currentPassword)
                    .font(.title3)
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            } else {
                SecureField("password", text: $currentPassword)
                    .font(.title3)
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            }
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
        }.frame(width: 343, height: 51)
            .background(Color.black.opacity(0.05))
            .cornerRadius(12)
            .padding(10)
            

        HStack {
            Image(systemName: "lock")
                .foregroundColor(.gray)
                .padding(.leading, 8)
            if isPasswordVisible {
                TextField("", text: $newPassword)
                    .font(.title3)
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            } else {
                SecureField("New Passwrd", text: $newPassword)
                    .font(.title3)
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            }
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
        }.frame(width: 343, height: 51)
            .background(Color.black.opacity(0.05))
            .cornerRadius(12)
            .padding(10)
            


        HStack {
            Image(systemName: "lock")
                .foregroundColor(.gray)
                .padding(.leading, 8)
            if isPasswordVisible {
                TextField("", text: $confirmNewPassword)
                    .font(.title3)
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            } else {
                SecureField("Confirm New Passwrd", text: $confirmNewPassword)
                    .font(.title3)
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            }
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
        } .frame(width: 343, height: 51)
            .background(Color.black.opacity(0.05))
            .cornerRadius(12)
            .padding(10)

        NavigationLink(destination: GestionUserSignIn()) {
                  EmptyView()
              }

       
        Button("Update Password") {
            print(userViewModel.user?._id ?? "")
            userViewModel.updatePassword(userId: userViewModel.user?._id ?? "", currentPassword: currentPassword, newPassword: newPassword, confirmNewPassword: confirmNewPassword)
        }
        .padding()
        .alert(isPresented: Binding<Bool>(get: { userViewModel.errorMessage != nil }, set: { _ in })) {
            Alert(title: Text("Error"), message: Text(userViewModel.errorMessage ?? "Unknown error"))
        }
        .alert(isPresented: Binding<Bool>(get: { userViewModel.successMessage != nil }, set: { _ in })) {
            Alert(title: Text("Success"), message: Text(userViewModel.successMessage ?? "Password updated successfully"))
        }
        .onAppear {
            userViewModel.getUser()
            print(userViewModel.getUser())
        }
        
               }
}



struct EditPassword_Previews: PreviewProvider {
    static var previews: some View {
        EditPassword()
    }
}
