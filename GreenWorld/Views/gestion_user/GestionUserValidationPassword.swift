//
//  GestionUserValidationPassword.swift
//  GreenWorld
//
//  Created by zouaoui on 28/11/2023.
//

import SwiftUI

struct GestionUserValidationPassword: View {
    var body: some View {
        NavigationView {
            VStack {
               
                
                Spacer()
                
                Image("validation")
                    .resizable()
                    .frame(width: 262, height: 236)
                    .padding(.top, 20)
                
                Text("Enter OTP")
                    .foregroundColor(Color("Secondary"))
                    .font(.system(size: 34))
                    .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 25))
                    .multilineTextAlignment(.center)
                
                Text("Check your email for the verification code.")
                    .foregroundColor(Color("colorPrimary"))
                    .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 10))
                
                Text("This code will expire in 10 minutes.")
                    .foregroundColor(Color("Secondary"))
                    .padding(EdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 16))
                
                Spacer()
                
          
                NavigationLink(destination: UserValidationCodeView()
                ) {
                    Text("Validate")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(EdgeInsets(top: 5, leading: 20, bottom: 15, trailing: 20))
                }
                Button(action: {
                    // Action for trying validation again
                }) {
                    Text("Try Again")
                        .foregroundColor(Color.blue)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                }
                
                Text("Didn't receive the code?")
                    .font(.system(size: 20))
                    .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
                
                Text("Resend Code")
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                    .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    GestionUserValidationPassword()
}
