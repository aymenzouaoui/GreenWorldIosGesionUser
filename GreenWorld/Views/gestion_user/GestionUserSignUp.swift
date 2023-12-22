//
//  GestionUserSignUp.swift
//  GreenWorld
//
//  Created by zouaoui on 28/11/2023.
//

import SwiftUI

struct GestionUserSignUp: View {

        
        @State private var email = ""
        @State private var password = ""
        @State private var name = ""
        @State private var numTel = ""
        @State private var navigationLinkActive: Bool = false
        @State private var showingAlert = false
        @State private var confirmPassword = ""
        @State private var isPasswordVisible = false
        var body: some View {
            VStack {
                
                HStack {
                   
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
              
                Text("Green World Register")
                    .font(.title)
                    .fontWeight(.black)
                    .padding(10)
                
                Text("Please enter your personal information")
                    .fontWeight(.medium)
                    .padding(10)
                
                VStack {
                    ZStack(alignment: .leading) {
                        if name.isEmpty {
                            Text("Username")
                                .foregroundColor(.gray)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        }
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.gray)
                                .padding(.leading, 8)
                            TextField("", text: $name)
                                .font(.title3)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        }
                    }
                    .frame(width: 343, height: 51)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(12)
                    .padding(10)
                    
                    
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
                    }
                
                ZStack(alignment: .leading) {
                    if numTel.isEmpty {
                        Text("+216")
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                    }
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        TextField("", text: $numTel)
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
             
                
                NavigationLink(destination: GestionUserSignIn(), isActive: $navigationLinkActive) {
                       EmptyView()
                   } .navigationBarItems(leading:
                                            HStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .frame(width: 70, height: 10)
                                                .padding(.leading,148)
                                            

                                                Spacer()
                                                
                                            }


                                        )
                   Button(action: {
                       // Perform sign-up action with user details
                       let newUser = User(userName: name, email: email, password: password, numTel: numTel) // Replace with the actual user details
                       UserService.shared.signUp(user: newUser) { result in
                           switch result {
                           case .success:
                               print ("labes")
                               // Signup successful
                               
                                      navigationLinkActive = true // Navigate to the next screen
                               // Set the flag to navigate to FlotteMainView
                           case .failure(let error):
                               // Signup failed
                               // Show an error message or perform appropriate action
                               print("Signup failed: \(error.localizedDescription)")
                           }
                       }
                   }) {
                       Text("SignUp")
                           .font(Font.custom("Inter", size: 20).weight(.bold))
                           .foregroundColor(.white)
                           .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                           .frame(width: 343, height: 51)
                           .background(Color(red: 0.06, green: 0.21, blue: 0.19))
                           .cornerRadius(12)
                   }
                  
          
                
                VStack(spacing: 20) {
                    Text("or Sign In with")
                        .foregroundColor(Color(red: 0.06, green: 0.21, blue: 0.19))
                    
                    VStack {
                        HStack{
                        VStack{
                   
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
                            .frame(width: 150, height: 30)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            // Redirect to Facebook Sign In
                            if let url = URL(string: "https://www.facebook.com/v10.0/dialog/oauth?client_id=your_facebook_app_id&redirect_uri=https://www.facebook.com/connect/login_success.html") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image("f")
                                    .resizable()
                                    .scaledToFit()
                                }
                                Text("Facebook")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .frame(width: 150, height: 30)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }
                }    }
            
            
            }
        
        
    }
    #Preview {
        GestionUserSignUp()
    }
