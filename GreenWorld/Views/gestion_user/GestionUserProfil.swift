import SwiftUI

struct GestionUserProfil: View {
    @StateObject private var userViewModel = UserViewModel()
    @State private var isEditProfileActive = false
    @State private var navigationLinkActive: Bool = false
    @State private var showLogoutConfirmation : Bool = false

   // @StateObject var login = Login()
    var body: some View {
        NavigationView{
            
            
            ZStack {
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.3)
                
                ScrollView {
                    
                    ZStack {
                        
                        
                        Text(StringConstants.profil)
                            .font(Font.custom("Inter", size: 27).weight(.semibold))
                            .foregroundColor(.black)
                            .offset(x: 1.50, y: -350)
                        
                    }
                    VStack {
                        NavigationLink(destination: GestionUserEditProfil()) {
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
                                                .frame(width: 120, height: 120) // Adjust the size of the clipped image
                                                .overlay(Ellipse().stroke(Color.green, lineWidth: 3)) // Add a stroke to the clipped image
                                                .shadow(color: Color(red: 0.40, green: 0.40, blue: 0.40, opacity: 0.15), radius: 10, y: 4)
                                                .position(x: 250, y: -70)
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

                            .padding(100)
                        }
                      
                     
                        
                        HStack{
                            VStack{
                                Text(userViewModel.user?.email ?? "")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .offset(x: -10, y: -205)
                                Text(userViewModel.user?.numTel ?? "")
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .offset(x: -10, y: -200)
                            }.padding(5)
                                .offset(x:0 , y: 40)
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 35))
                                .foregroundColor(Color(red: 0.06, green: 0.21, blue: 0.19))
                                .offset(x: -60, y: -270)
                        }.padding(30)
                        HStack{
                            Text(userViewModel.user?.score != nil ? String(userViewModel.user!.score!) : "")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .offset(x: -70, y: -230)
                            
                            
                            Text("Record")
                                .font(.system(size: 13))
                                .fontWeight(.light)
                                .foregroundColor(.black)
                                .offset(x: -55, y: -230)
                            
                        }.padding(10)
                            .offset(x: 0, y: -100)
                   
                    }
                    HStack{
                       
                        VStack(alignment: .leading, spacing: 0) {
                            NavigationLink(destination: MainTabbedView()) {
                            Text("Accueil")
                                .font(Font.custom("SF Pro Text", size: 14).weight(.medium))
                                .lineSpacing(18)
                                .lineSpacing(18)
                                .foregroundColor(.white)
                            }    }
                        .padding(
                            EdgeInsets(top: 5.50, leading: 16, bottom: 6.50, trailing: 16)
                        )
                        .frame(width: 91, height: 30)
                        .background(Color(red: 0.13, green: 0.61, blue: 0.49))
                        .cornerRadius(10)
                        .position(x:50, y:-220)
                    }
                    
                    
                    
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                        
                            .frame(width: 500, height: 0.5)
                            .background(Color.black)
                            .cornerRadius(2)
                            .opacity(0.2)
                            .position(x:350, y: -200)
                    }
                  
                    HStack{
                        
                        Image("quiz")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .position(x: 240, y: -170)
                        
                        Text(StringConstants.quiz)
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .position(x:170, y:-170)
                        
                        Image("arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 30)
                            .position(x:100, y: -170)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                        
                            .frame(width: 300, height: 0.5)
                            .background(Color.black)
                            .cornerRadius(2)
                            .opacity(0.2)
                            .position(x:-200, y: -140)
                        
                        
                    }
                    HStack{
                        
                        Image("event")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .position(x: 240, y: -140)
                        
                        Text("My Event")
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .position(x:170, y:-140)
                        
                        Image("arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 30)
                            .position(x:100, y: -140)
                        
                        Rectangle()
                            .foregroundColor(.clear)
                        
                            .frame(width: 300, height: 0.5)
                            .background(Color.black)
                            .cornerRadius(2)
                            .opacity(0.2)
                            .position(x:-200, y: -110)
                        
                        
                    }
                    HStack{
                        
                        Image("achat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .position(x: 240, y: -110)
                        
                        Text(StringConstants.achat)
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .position(x:170, y:-110)
                        
                        Image("arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 30)
                            .position(x:100, y: -110)
                        
                        
                        Rectangle()
                            .foregroundColor(.clear)
                        
                            .frame(width: 300, height: 0.5)
                            .background(Color.black)
                            .cornerRadius(2)
                            .opacity(0.2)
                            .position(x:-200, y: -80)
                        
                        
                    }
                    
                    NavigationLink(destination: GestionUserSignIn(), isActive: $navigationLinkActive) {
                        EmptyView()
                    }
                    Button(action: {
                                       showLogoutConfirmation = true
                                   }) {
                                       Text("Déconnecter")
                                           .font(Font.custom("Inter", size: 20).weight(.bold))
                                           .foregroundColor(.white)
                                           .padding()
                                           .frame(width: 343, height: 51)
                                           .background(Color(red: 0.13, green: 0.61, blue: 0.49))
                                           .cornerRadius(12)
                                   }
                                   .position(x:375,y:0)
                                   .alert(isPresented: $showLogoutConfirmation) {
                                       Alert(
                                           title: Text("Déconnexion"),
                                           message: Text("Êtes-vous sûr de vouloir vous déconnecter ?"),
                                           primaryButton: .destructive(Text("Déconnecter")) {
                                               // Handle logout action
                                               navigationLinkActive = true
                                               //login.logout() // Uncomment if needed
                                           },
                                           secondaryButton: .cancel()
                                       )
                                   }
                    
                    
                }
                
                
            }
            .onAppear {
                
                userViewModel.getUser()
                print(userViewModel.getUser())
            }
        }  .navigationBarBackButtonHidden(true)
         
          
            

    }
    
   
    
}


#Preview {
    GestionUserProfil()
}



