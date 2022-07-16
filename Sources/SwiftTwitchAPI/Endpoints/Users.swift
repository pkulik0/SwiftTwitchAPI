//
//  Users.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

extension SwiftTwitchAPI {
    struct UserResponse: Codable {
        let id: String
        let login: String
        let displayName: String
        let type: String
        let broadcasterType: String
        let welcomeDescription: String
        let profileImageURL: String
        let offlineImageURL: String
        let viewCount: Int
        let email: String?
        let createdAt: String

        enum CodingKeys: String, CodingKey {
            case id, login, type, email
            case displayName = "display_name"
            case broadcasterType = "broadcaster_type"
            case welcomeDescription = "description"
            case profileImageURL = "profile_image_url"
            case offlineImageURL = "offline_image_url"
            case viewCount = "view_count"
            case createdAt = "created_at"
        }
    }
    
    func getUsers(ids: [String] = [], logins: [String] = [], onCompletion: @escaping (Result<Paginated<UserResponse>, TwitchAPIError>) -> Void) {
        var endpoint = "users?"
        ids.forEach({ endpoint.append("id=\($0)&") })
        logins.forEach({ endpoint.append("login=\($0)&") })
        
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
    
    func updateCurrentUser(description: String, onCompletion: @escaping (Result<Paginated<UserResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "users?description=\(description)", onCompletion: onCompletion)
    }
}
