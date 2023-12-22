import Foundation

struct User: Codable {
    let _id: String?
    let email: String?
    let password: String?
    let nom: String?
    let prenom: String?
    let address: String?
    let cin: String?
    let resetCode: String?
    let userName: String?
    let numTel: String?
    let score: Int?
    let lastPassword: String?
    let isValid: Bool?
    let imageRes: String?
    let token: String?
    let role: Role?
    
    init(id: String? = nil, userName: String?, email: String, password: String, numTel: String?, imageRes: String? = nil) {
        self._id = id
        self.userName = userName
        self.email = email
        self.password = password
        self.numTel = numTel
        self.imageRes = imageRes
        self.score = 0
        self.isValid = true
        self.nom = nil
        self.prenom = nil
        self.address = nil
        self.cin = nil
        self.resetCode = nil
        self.lastPassword = nil
        self.token = nil
        self.role = .user
    }
    
    enum Role: String, Codable {
        case admin
        case user
    }
    
    private enum CodingKeys: String, CodingKey {
        case _id
        case email
        case password
        case nom
        case prenom
        case address = "adress"
        case cin
        case resetCode
        case userName
        case numTel
        case score
        case lastPassword
        case isValid
        case imageRes
        case token
        case role
    }
}
