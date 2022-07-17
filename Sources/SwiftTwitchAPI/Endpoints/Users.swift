//
//  Users.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

public extension SwiftTwitchAPI {
    struct UserResponse: Codable, Identifiable {
        public let id: String
        public let login: String
        public let displayName: String
        public let type: String
        public let broadcasterType: String
        public let welcomeDescription: String
        public let profileImageURL: String
        public let offlineImageURL: String
        public let viewCount: Int
        public let email: String?
        public let createdAt: String

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
        public let fromID: String
        public let fromLogin: String
        public let fromName: String
        public let toID: String
        public let toName: String
        public let followedAt: String

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
    
    struct BlockedUserResponse: Codable {
        public let userID: String
        public let userLogin: String
        public let displayName: String

        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case userLogin = "user_login"
            case displayName = "display_name"
        }
    }

    
    func getUserBlocklist(userID: String, after: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<BlockedUserResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        let endpoint = "users/blocks?broadcaster_id=\(userID)"
        
        if let after = after {
            parameters["after"] = after
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        
        requestAPI(endpoint: appendParameters(parameters, to: endpoint), onCompletion: onCompletion)
    }
    
    func addUserToBlocklist(targetUserID: String, onCompletion: @escaping (Result<Int, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "users/blocks?target_user_id=\(targetUserID)", requestMethod: .PUT, onCompletion: onCompletion)
    }
    
    func removeUserFromBlocklist(targetUserID: String, onCompletion: @escaping (Result<Int, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "users/blocks?target_user_id=\(targetUserID)", requestMethod: .PUT, onCompletion: onCompletion)
    }
}
