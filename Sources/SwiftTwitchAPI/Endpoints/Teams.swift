//
//  Teams.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

extension SwiftTwitchAPI {
    public struct ChannelTeamResponse: Codable, Identifiable {
        public let broadcasterID: String
        public let broadcasterName: String
        public let broadcasterLogin: String
        public let backgroundImageURL: String?
        public let banner: String?
        public let createdAt: String
        public let updatedAt: String
        public let info: String
        public let thumbnailURL: String
        public let teamName: String
        public let teamDisplayName: String
        public let id: String

        enum CodingKeys: String, CodingKey {
            case banner, info, id
            case broadcasterID = "broadcaster_id"
            case broadcasterName = "broadcaster_name"
            case broadcasterLogin = "broadcaster_login"
            case backgroundImageURL = "background_image_url"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case thumbnailURL = "thumbnail_url"
            case teamName = "team_name"
            case teamDisplayName = "team_display_name"
        }
    }
    
    public func getChannelTeams(broadcasterID: String, onCompletion: @escaping (Result<Paginated<ChannelTeamResponse>, TwitchAPIError>) -> Void) {
        requestTwitchAPI(endpoint: "teams/channel?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    public struct TeamResponse: Codable, Identifiable {
        public let id: String
        public let users: [User]
        public let backgroundImageURL: String?
        public let banner: String?
        public let createdAt: String
        public let updatedAt: String
        public let info: String
        public let thumbnailURL: String
        public let teamName: String
        public let teamDisplayName: String

        enum CodingKeys: String, CodingKey {
            case users, banner, info, id
            case backgroundImageURL = "background_image_url"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case thumbnailURL = "thumbnail_url"
            case teamName = "team_name"
            case teamDisplayName = "team_display_name"
        }
        
        public struct User: Codable {
            public let userID: String
            public let userName: String
            public let userLogin: String

            enum CodingKeys: String, CodingKey {
                case userID = "user_id"
                case userName = "user_name"
                case userLogin = "user_login"
            }
        }
    }
    
    public func getTeamInformation(name: String? = nil, id: String? = nil, onCompletion: @escaping (Result<Paginated<TeamResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        
        if let name = name {
            parameters["name"] = name
        }
        if let id = id {
            parameters["id"] = id
        }
        
        let endpoint = appendParameters(parameters, to: "teams")
        requestTwitchAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
