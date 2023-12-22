//
//  GestionUserSignIn.swift
//  GreenWorld
//
//  Created by zouaoui on 28/11/2023.
//

import SwiftUI
import FBSDKLoginKit


struct GestionUserSignIn: View {
    @State private var username = ""
    @State private var numTel = ""
    @State private var email = ""

        @State private var password = ""
        @State private var rememberMe = false
        @State private var isPasswordVisible = false
        @State private var navigationLinkActive: Bool = false
        @State private var wrongpassword = ""
        @State private var navigateToLocation = false
        @State private var isLoggedIn = false
        @State var isLogged = false
    @State private var userService = UserService.shared

        var body: some View {
            
         
            NavigationView {
                        
                        
              
                            
                           VStack {  HStack {
                               
                               Image("ic_logo")
                                   .resizable()
                                   .padding()
                                   .frame(width: getRelativeWidth(150.0),
                                          height: getRelativeWidth(115.0), alignment: .center)
                                   .scaledToFit()
                                   .clipped()
                                  
                                        
                               
                               
                           }
                           .frame(width: getRelativeWidth(181.0), height: getRelativeHeight(41.0),
                                  alignment: .leading)
                                   
                                   
                   
                    Text("Welcome Green World")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(40)
                        
                    
                    Text("Please enter your data to connect")
                    
                               ZStack(alignment: .leading) {
                                   if email.isEmpty {
                                       Text("Email")
                                           .foregroundColor(.gray)
                                           .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                                   }
                                   HStack {
                                       Image(systemName: "envelope")
                                           .foregroundColor(.gray)
                                           .padding(.leading, 8)
                                       TextField("", text: $email)
                                           .font(.title3)
                                           .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                                   }
                               }
                               .frame(width: 343, height: 51)
                               .background(Color.black.opacity(0.05))
                               .cornerRadius(12)
                               .padding(10)
                               
                    
                    ZStack(alignment: .leading) {
                        if password.isEmpty {
                            Text("Password")
                                .foregroundColor(.gray)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        }
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                                .padding(.leading, 8)
                            if isPasswordVisible {
                                TextField("", text: $password)
                                    .font(.title3)
                                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            } else {
                                SecureField("", text: $password)
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
                        }
                    }
                    .frame(width: 343, height: 51)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .padding(10)
                    
                    Toggle("Remember Me", isOn: $rememberMe)
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                    
                               NavigationLink(destination: GestionUserForgetPassword()
                    ) {
                        Text("Forgot password?")
                    }
                    .font(Font.custom("Inter", size: 14).weight(.semibold))
                    .foregroundColor(Color(red: 0.06, green: 0.21, blue: 0.19))
                    .padding(EdgeInsets(top: 5, leading: 55, bottom: 5, trailing: -150))
                    
                    NavigationLink(destination: GestionUserProfil(), isActive: $navigationLinkActive) {
                           EmptyView()
                       }  .navigationBarBackButtonHidden(true)
                               Button(action: {
                                   // Call the signIn method from the UserService
                                   userService.signIn(email: email, password: password)
                                // userService.signIn(email: "Arafet@gmail.com", password: "12345678")
                                   
                                   { result in
                                       switch result {
                                       case .success(let token):
                                          

                                           // Handle successful sign-in, such as saving the token in the app's data or performing navigation
                                    
                                           navigationLinkActive = true // Navigate to the next screen
                                       case .failure(let error):
                                           // Handle sign-in failure, such as displaying an error message to the user
                                           print("Sign-in failed. Error: \(error)")
                                           // You can set a variable to show an error message to the user, e.g., wrongpassword = "Invalid email or password"
                                       }
                                   }
                               }) {
                                   Text("Login")
                                       .font(Font.custom("Inter", size: 20).weight(.bold))
                                       .foregroundColor(.white)
                                       .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                                       .frame(width: 343, height: 51)
                                       .background(Color(red: 0.06, green: 0.21, blue: 0.19))
                                       .cornerRadius(12)
                               }
                    
                    NavigationLink(destination: VStack {
                        GestionUserSignUp()
                     
                    }) {
                        Text("Create your personal account!")
                    }
                    .font(Font.custom("Inter", size: 16).weight(.black))
                    .foregroundColor(Color(red: 0.06, green: 0.21, blue: 0.19))
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 30))
                    
                    
                    
                    VStack(spacing: 20) {
                        Text("or Sign In with")
                            .foregroundColor(.gray)
                        
                        VStack {
                            HStack{
                                
                            
                                HStack{
                                    Button(action: {
                                        // Redirect to Google Sign In
                                        if let url = URL(string: "https://accounts.google.com/ServiceLogin") {
                                            UIApplication.shared.open(url)
                                        }
                                    }) {
                                        HStack {
                                            Image("g")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                        Text("Google")
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                    .frame(width: 130, height: 30)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                                }
                                
                                Button(action: {
                                    LoginManager().logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                                        if let error = error {
                                            print("Facebook login failed: \(error.localizedDescription)")
                                            return
                                        }
                                        
                                        if let result = result {
                                            if !result.isCancelled {
                                                // Facebook login successful
                                                // Access the user's Facebook data and perform the necessary actions
                                                let accessToken = AccessToken.current
                                                
                                                // Request for user's email, first name, last name, and profile picture
                                                let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
                                                let request = GraphRequest(graphPath: "me", parameters: parameters, tokenString: accessToken?.tokenString, version: nil, httpMethod: .get)
                                                
                                                request.start { connection, result, error in
                                                    if let error = error {
                                                        print("Failed to fetch user's Facebook data: \(error.localizedDescription)")
                                                        return
                                                    }
                                                    
                                                    if let userData = result as? [String: Any],
                                                       let email = userData["email"] as? String,
                                                       let firstName = userData["first_name"] as? String,
                                                       let lastName = userData["last_name"] as? String,
                                                       let pictureData = userData["picture"] as? [String: Any],
                                                       let pictureUrl = pictureData["data"] as? [String: Any],
                                                       let pictureUrlString = pictureUrl["url"] as? String {
                                                        // Use the retrieved email, first name, last name, and profile picture URL as needed
                                                        let fullName = "\(firstName) \(lastName)"
                                                        print("Email: \(email)")
                                                        print("Full Name: \(fullName)")
                                                        print("Profile Picture URL: \(pictureUrlString)")
                                                        
                                                        // Navigate to the desired view
                                                        navigationLinkActive = true
                                                    }
                                                }
                                            } else {
                                                print("Facebook login cancelled")
                                            }
                                        }
                                    }
                                }){
                                    HStack {
                                        Image("f")
                                            .resizable()
                                            .scaledToFit()
                                    }
                                    Text("Facebook")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                .frame(width: 130, height: 30)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                            }
                        }
                        
                    } .navigationBarBackButtonHidden(true)
                
                   
                    
                } .navigationBarBackButtonHidden(true)
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }

#Preview {
    GestionUserSignIn()
}
