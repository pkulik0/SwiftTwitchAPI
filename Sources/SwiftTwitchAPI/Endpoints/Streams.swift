//
//  Streams.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

extension SwiftTwitchAPI {
    struct StreamResponse: Codable {
        let id: String
        let userID: String
        let userLogin: String
        let userName: String
        let gameID: String
        let gameName: String
        let type: String
        let title: String
        let viewerCount: Int
        let startedAt: String
        let language: String
        let thumbnailURL: String
        let tagIDS: [String]?
        let isMature: Bool

        enum CodingKeys: String, CodingKey {
            case id, type, title, language
            case userID = "user_id"
            case userLogin = "user_login"
            case userName = "user_name"
            case gameID = "game_id"
            case gameName = "game_name"
            case viewerCount = "viewer_count"
            case startedAt = "started_at"
            case thumbnailURL = "thumbnail_url"
            case tagIDS = "tag_ids"
            case isMature = "is_mature"
        }
    }
    
    func getStreams(gameIDs: [String] = [], languages: [String] = [], userIDs: [String] = [], userLogins: [String] = [], after: String? = nil, before: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<StreamResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        
        if let after = after {
            parameters["after"] = after
        }
        if let before = before {
            parameters["before"] = before
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        
        var endpoint = "streams?"
        gameIDs.forEach({ endpoint.append("game_id=\($0)&") })
        languages.forEach({ endpoint.append("language=\($0)&") })
        userIDs.forEach({ endpoint.append("user_id=\($0)&") })
        userLogins.forEach({ endpoint.append("user_login=\($0)&") })
        endpoint = appendParameters(parameters, to: endpoint)
        
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
    
    func getFollowedStreams(userID: String, after: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<StreamResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        
        if let after = after {
            parameters["after"] = after
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        
        requestAPI(endpoint: "streams/followed?user_id=\(userID)", onCompletion: onCompletion)
    }
}
