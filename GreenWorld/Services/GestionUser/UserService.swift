



import Foundation

class UserService {
    static let shared = UserService()
    private let baseURL = "http://172.18.1.28:9090"

    
  
    
    
            

        
       

    
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let loginURL = URL(string: "\(baseURL)/auth/login")!
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginData = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: loginData)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
           
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                // Login successful
                if let data = data {
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        
                        // Save user ID to UserDefaults
                        UserDefaults.standard.set(user._id, forKey: "userID")
                        
                        completion(.success(user))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.noData))
                }
            } else {
                // Login failed
                completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
            }
        }.resume()
    }
    
    
    
    func signUp(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        let signUpURL = URL(string: "\(baseURL)/user")!
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        request.httpBody = try? encoder.encode(user)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                // Signup successful
                completion(.success(()))
            } else {
                // Signup failed
                completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
            }
        }.resume()
    }
    
    func getUser(userID: String, completion: @escaping (Result<User, Error>) -> Void) {
            let getUserURL = URL(string: "\(baseURL)/user/\(userID)")!
            print("useruser")
            URLSession.shared.dataTask(with: getUserURL) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let user = try decoder.decode(User.self, from: data)
                            completion(.success(user))
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
                } else if httpResponse.statusCode == 404 {
                    completion(.failure(NetworkError.noData))
                } else {
                    completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
                }
            }.resume()
        }
    
    func sendResetCode(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/user/sendResetCode")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            switch httpResponse.statusCode {
            case 200:
                completion(.success("Reset code sent successfully."))
            case 404:
                completion(.failure(NetworkError.userIDNotFound))
            default:
                completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
            }
        }.resume()
    }

        
    
    func updatePassword(userId: String, currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        let updatePasswordURL = URL(string: "\(baseURL)/user/updatePassword/\(userId)")!

        var request = URLRequest(url: updatePasswordURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "currentPassword": currentPassword,
            "newPassword": newPassword,
            "confirmNewPassword": confirmNewPassword
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "NetworkError", code: 0, userInfo: nil)))
                return
            }

            do {
                let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let message = responseJSON?["message"] as? String {
                    completion(.success(message))
                } else {
                    completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
   
    func deleteUser(userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = UserDefaults.standard.string(forKey: "UserID") else {
            completion(.failure(NetworkError.userIDNotFound))
            return
        }
        
        guard let url = URL(string: "\(baseURL)/User/delete/\(userID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Process the response if needed
            
            completion(.success(()))
        }.resume()
    }
    
    func verifyResetCode(email: String, resetCode: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/admin/verifyResetCode")!  // Replace with your actual server URL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": email,
            "resetCode": resetCode
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
     
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        completion(.success(user))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.noData))
                }
            } else {
                // Handle different status codes appropriately
                if let data = data,
                   let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let message = jsonObject["message"] as? String {
                    completion(.failure(NetworkResponseError.custom(message: message)))
                } else {
                    completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
                }
            }
        }.resume()
    }
    
    
    func updatenewPassword(email: String, newPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
            guard let url = URL(string: "\(baseURL)/admin/newPassword") else {
                completion(.failure(NetworkError.invalidURL))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let body: [String: String] = ["email": email, "newPassword": newPassword]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(.failure(NetworkError.invalidResponse))
                        return
                    }

                    if httpResponse.statusCode == 200, let data = data {
                        do {
                            if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                               let message = jsonObject["message"] as? String {
                                completion(.success(message))
                            } else {
                                completion(.failure(NetworkError.invalidData))
                            }
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
                    }
                }
            }.resume()
        }

    
    
    }
    
    
enum NetworkResponseError: Error {
    case custom(message: String)
}

enum NetworkError: Error {
    case invalidData
    case userIDNotFound
    case invalidURL
    case invalidResponse
    case requestFailed(Int)
    case noData
}


enum UserServiceError: Error {
    case invalidURL
    case noData
}

