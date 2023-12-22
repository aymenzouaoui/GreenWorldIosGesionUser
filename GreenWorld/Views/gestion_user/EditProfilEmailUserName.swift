import SwiftUI

struct EditEmail: View {
    @StateObject private var userViewModel = UserViewModel()
    @State private var selectedImage: Image?
    @State private var showImagePicker = false
    @State private var selectedImageURL: URL?
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var userImage: Image? = Image("user") // Replace "user" with your default image name
    @State private var buttonScale: CGFloat = 1.0 // Added for button animation

    var body: some View {
        ZStack {
            Color.green.opacity(0.5).ignoresSafeArea()

            VStack {
                Button(action: {
                    showImagePicker = true
                }) {
                    userImage?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .padding()
                }

                Button(action: {
                    // Add your action code here
                }) {
                    Text("Save Image")
                }

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
                            Spacer().frame(width: 7)
                            Image(systemName: "person")
                                .foregroundColor(Color(red: 0.13, green: 0.61, blue: 0.49))
                                .frame(width: 20, height: 20)
                            Spacer()
                        }
                    )

                TextField("Phone Number", text: $phoneNumber)
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
                            Spacer().frame(width: 7)
                            Image(systemName: "phone")
                                .foregroundColor(Color(red: 0.13, green: 0.61, blue: 0.49))
                                .frame(width: 20, height: 20)
                            Spacer()
                        }
                    )

                Button(action: {
                    // Add your action code here
                }) {
                    Text("Update Profile")
                        .font(Font.custom("Inter", size: 20).weight(.bold))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        .frame(width: 200, height: 51)
                        .background(Color(red: 0.13, green: 0.61, blue: 0.49))
                        .cornerRadius(12)
                        .scaleEffect(buttonScale) // Apply button scale
                }
                .onTapGesture {
                    withAnimation {
                        buttonScale = 0.8
                    }

                    // Add your action code here

                    withAnimation {
                        buttonScale = 1.0
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct EditMotPasseView_Previews: PreviewProvider {
    static var previews: some View {
        EditEmail()
    }
}
