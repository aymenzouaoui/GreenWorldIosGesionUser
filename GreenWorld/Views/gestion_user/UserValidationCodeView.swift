import SwiftUI

struct UserValidationCodeView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var userViewModel = UserViewModel()
    let email: String  // Email passed from the previous view

    @State private var code1: String = ""
    @State private var code2: String = ""
    @State private var code3: String = ""
    @State private var code4: String = ""
    @State private var navigateToResetPassword = false
    @State private var showToast = false

    var body: some View {
        NavigationView {
            VStack {
                // Back arrow and title
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

                Text("Confirmation")
                    .foregroundColor(Color.green)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 25)

                Text("Enter the validation code sent to your email.")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.top, 20)

                // Code input fields
                HStack(spacing: 15) {
                    ForEach(0..<4, id: \.self) { index in
                        CodeInputField(text: binding(for: index))
                    }
                }
                .padding(.top, 15)

                // Verify button
                Button(action: {
                    print("verrrrrr")
                    verifyCode()

                }) {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 200)

                // Resend code button
                Button(action: {
                    resendCode()
                }) {
                    Text("Didn't receive the code? Resend Code")
                        .foregroundColor(Color.green)
                }
                .padding(.top, 10)

                // Navigation link to ResetPasswordView
                NavigationLink(destination: ResetPasswordView(), isActive: $navigateToResetPassword) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
            }
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }

    // Binding for each code input field
    private func binding(for index: Int) -> Binding<String> {
        switch index {
        case 0: return $code1
        case 1: return $code2
        case 2: return $code3
        case 3: return $code4
        default: fatalError("Index out of range")
        }
    }

    private func verifyCode() {
        let fullCode = code1 + code2 + code3 + code4
        userViewModel.verifyResetCode(email: email, resetCode: fullCode) { isSuccess in
            DispatchQueue.main.async {
                if isSuccess {
                    self.navigateToResetPassword = true
                } else {
                    self.showToast = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.showToast = false
                    }
                }
            }
        }
    }

    // Function to resend the verification code
    private func resendCode() {
        userViewModel.sendResetCode(email: email)
    }
}

// Custom view for a single code input field
struct CodeInputField: View {
    @Binding var text: String

    var body: some View {
        TextField("", text: $text)
            .onChange(of: text) { newValue in
                if newValue.count > 1 || !newValue.allSatisfy({ $0.isNumber }) {
                    text = String(newValue.prefix(1))
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 50, height: 50)
            .font(.system(size: 24, weight: .bold))
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
    }
}

// Preview for the view
struct UserValidationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        UserValidationCodeView(email: "example@example.com")
    }
}
