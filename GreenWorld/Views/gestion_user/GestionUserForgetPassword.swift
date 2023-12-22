import SwiftUI

struct GestionUserForgetPassword: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var userViewModel = UserViewModel()
    @State private var selectedMethod = "Email"
    @State private var emailOrPhone: String = ""
    @State private var showAlert = false
    @State private var navigateToValidation = false
    @State private var isInputValid = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color.blue)
                    }
                    Spacer()
                }
                .padding()

                Spacer()

                Image("validation") // Ensure this image is in your assets
                    .resizable()
                    .frame(width: 262, height: 236)
                    .padding(.top, 20)

                Picker("Method", selection: $selectedMethod) {
                    Text("Email").tag("Email")
                    Text("Phone Number").tag("Phone")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                TextField(selectedMethod == "Email" ? "Email" : "Phone Number", text: $emailOrPhone)
                                    .keyboardType(selectedMethod == "Email" ? .emailAddress : .phonePad)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                                    .padding(.horizontal, 20)
                                    .onChange(of: emailOrPhone) { newValue in
                                        // Validation de la saisie
                                        isInputValid = !newValue.isEmpty
                                    }

                Button("Resend Code") {
                                    if isInputValid {
                                        if selectedMethod == "Email" {
                                            resendCode()
                                        } else {
                                            // Handle phone number case if necessary
                                        }
                                    } else {
                                        // Afficher une alerte ou un message à l'utilisateur sur une saisie invalide
                                    }
                                }
                                .foregroundColor(Color.green)
                                .padding()
                .padding()
                NavigationLink(destination: UserValidationCodeView(email: "example@example.com"), isActive: $navigateToValidation) {
                                    Button("Validate") {
                                        withAnimation {
                                            // Ajouter l'effet de mise à l'échelle lorsqu'il est pressé
                                            navigateToValidation = true
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(isInputValid ? Color.green : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .padding(.horizontal, 20)
                                    .scaleEffect(navigateToValidation ? 0.9 : 1.0) // Appliquer la mise à l'échelle ici
                                    .animation(.spring()) // Ajouter une animation fluide
                                }
                .navigationBarBackButtonHidden(true)

                Spacer()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Message"),
                    message: Text("Your reset code has been sent."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }

    private func resendCode() {
        userViewModel.sendResetCode(email: emailOrPhone)
        showAlert = true
    }
}

struct GestionUserForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        GestionUserForgetPassword()
    }
}
