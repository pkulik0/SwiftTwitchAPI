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
    
    struct FollowResponse: Codable {
        let fromID: String
        let fromLogin: String
        let fromName: String
        let toID: String
        let toName: String
        let followedAt: String

        enum CodingKeys: String, CodingKey {
            case fromID = "from_id"
            case fromLogin = "from_login"
            case fromName = "from_name"
            case toID = "to_id"
            case toName = "to_name"
            case followedAt = "followed_at"
        }
    }
    
    func getFollowsFromUser(userID: String, after: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<FollowResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        let endpoint = "users/follows?from_id=\(userID)&"
        
        if let after = after {
            parameters["after"] = after
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        
        requestAPI(endpoint: appendParameters(parameters, to: endpoint), onCompletion: onCompletion)
    }
    
    func getFollowsToUser(userID: String, after: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<FollowResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        let endpoint = "users/follows?to_id=\(userID)&"
        
        if let after = after {
            parameters["after"] = after
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        
        requestAPI(endpoint: appendParameters(parameters, to: endpoint), onCompletion: onCompletion)
    }
}
