//
//  Teams.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

extension SwiftTwitchAPI {
    struct ChannelTeamResponse: Codable {
        let broadcasterID: String
        let broadcasterName: String
        let broadcasterLogin: String
        let backgroundImageURL: String?
        let banner: String?
        let createdAt: String
        let updatedAt: String
        let info: String
        let thumbnailURL: String
        let teamName: String
        let teamDisplayName: String
        let id: String

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
    
    func getChannelTeams(broadcasterID: String, onCompletion: @escaping (Result<Paginated<ChannelTeamResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "teams/channel?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    struct TeamResponse: Codable {
        let id: String
        let users: [User]
        let backgroundImageURL: String?
        let banner: String?
        let createdAt: String
        let updatedAt: String
        let info: String
        let thumbnailURL: String
        let teamName: String
        let teamDisplayName: String

        enum CodingKeys: String, CodingKey {
            case users, banner, info, id
            case backgroundImageURL = "background_image_url"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case thumbnailURL = "thumbnail_url"
            case teamName = "team_name"
            case teamDisplayName = "team_display_name"
        }
        
        struct User: Codable {
            let userID: String
            let userName: String
            let userLogin: String

            enum CodingKeys: String, CodingKey {
                case userID = "user_id"
                case userName = "user_name"
                case userLogin = "user_login"
            }
        }
    }
    
    func getTeamInformation(name: String? = nil, id: String? = nil, onCompletion: @escaping (Result<Paginated<TeamResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        
        if let name = name {
            parameters["name"] = name
        }
        if let id = id {
            parameters["id"] = id
        }
        
        let endpoint = appendParameters(parameters, to: "teams")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
