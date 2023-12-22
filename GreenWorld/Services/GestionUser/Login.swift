import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var isLoading = false
    @Published var error: Error?
    @Published var userSign: UserSign?
    @Published var user: User?
    @Published var token: String?
    
    private let userService: UserService
    private var cancellables = Set<AnyCancellable>()
    
    
    init(userService: UserService = UserService.shared) {
        self.userService = userService
    }
    
    func forgetPassword(numTel: String, completion: @escaping (Result<String, Error>) -> Void) {
            // Implement your password recovery logic here
            // For example, you might send an API request to get an OTP
            
            // Simulate a successful response with an OTP
            let simulatedOTP = "123456"
            completion(.success(simulatedOTP))
            
            // In a real-world scenario, you would replace the simulatedOTP with the actual response from your API or service.
        }
    
    func signIn(email: String, password: String) {
        isLoading = true
        
        userService.signIn(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success(let user):
                self.isSignedIn = true
                self.error = nil
                
                // Save the token in the user defaults
                UserDefaults.standard.setValue(user._id, forKey: "UserID")
               
                
                // Call getUser to fetch the user data
                self.getUser()
            case .failure(let error):
                self.isSignedIn = false
                self.error = error
            }
        }
    }
    func signUp(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        
        userService.signUp(user: user) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success:
                self.isSignedIn = true
                self.error = nil
                completion(.success(()))
            case .failure(let error):
                self.isSignedIn = false
                self.error = error
                completion(.failure(error))
            }
        }
    }
    
    
    func getUser() {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else {
            // User ID not found in UserDefaults
            return
        }
        
        // Call the userService.getUser() method with the retrieved user ID
        userService.getUser(userID: userID) { [weak self] result in
            switch result {
            case .success(let user):
                // Update the user property
                DispatchQueue.main.async {
                    self?.user = user
                }
            case .failure(let error):
                // Handle error
                print("Failed to get user: \(error)")
            }
        }
    }
    // Other methods...
}

struct UserSign: Codable {
    let id: UUID
    let email: String
}

