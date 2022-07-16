//
//  Channel.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

extension SwiftTwitchAPI {
    struct ChannelResponse: Codable {
        let broadcasterID: String
        let broadcasterLogin: String
        let broadcasterName: String
        let broadcasterLanguage: String
        
        let gameName: String
        let gameID: String
        
        let title: String
        let delay: Int
        
        enum CodingKeys: String, CodingKey {
            case broadcasterID = "broadcaster_id"
            case broadcasterLogin = "broadcaster_login"
            case broadcasterName = "broadcaster_name"
            case broadcasterLanguage = "broadcaster_language"
            case gameName = "game_name"
            case gameID = "game_id"
            case title
            case delay
        }
    }
    
    func getChannel(broadcasterIDs: [String], onCompletion: @escaping (Result<Paginated<ChannelResponse>, TwitchAPIError>) -> Void) {
        if broadcasterIDs.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        var endpoint = "channels?"
        broadcasterIDs.forEach({ endpoint.append("broadcaster_id=\($0)&") })

        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }

    func modifyChannel(broadcasterID: String, gameID: String? = nil, broadcasterLanguage: String? = nil, title: String? = nil, delay: Int? = nil, onCompletion: @escaping (Result<Int, TwitchAPIError>) -> Void) {
        
        var requestBody: [String: Any] = [:]
        if let gameID = gameID {
            requestBody["game_id"] = gameID
        }
        if let broadcasterLanguage = broadcasterLanguage {
            requestBody["broadcaster_language"] = broadcasterLanguage
        }
        if let title = title {
            requestBody["title"] = title
        }
        if let delay = delay {
            requestBody["delay"] = delay
        }
        
        if requestBody.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        requestAPI(endpoint: "channels?broadcaster_id=\(broadcasterID)", requestMethod: .PATCH, requestBody: requestBody, onCompletion: onCompletion)
    }
    
    struct ChannelEditorResponse: Codable {
        let userID: String
        let userName: String
        let createdAt: String
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case userName = "user_name"
            case createdAt = "created_at"
        }
    }
    
    func getChannelEditors(broadcasterID: String, onCompletion: @escaping (Result<Paginated<ChannelEditorResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "channels/editors?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    struct CreatorGoalResponse: Codable {
        let id: String
        let broadcasterID: String
        let broadcasterName: String
        let broadcasterLogin: String
        let type: String
        let welcomeDescription: String
        let currentAmount: Int
        let targetAmount: Int
        let createdAt: String

        enum CodingKeys: String, CodingKey {
            case id, type
            case broadcasterID = "broadcaster_id"
            case broadcasterName = "broadcaster_name"
            case broadcasterLogin = "broadcaster_login"
            case welcomeDescription = "description"
            case currentAmount = "current_amount"
            case targetAmount = "target_amount"
            case createdAt = "created_at"
        }
    }
    
    func getCreatorGoals(broadcasterID: String, onCompletion: @escaping (Result<Paginated<CreatorGoalResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "goals?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    struct ChannelSearchResponse: Codable {
        let broadcasterLanguage: String
        let broadcasterLogin: String
        let displayName: String
        let gameID: String
        let gameName: String
        let id: String
        let isLive: Bool
        let tagsIDS: [String]?
        let thumbnailURL: String
        let title: String
        let startedAt: String?

        enum CodingKeys: String, CodingKey {
            case id, title
            case broadcasterLanguage = "broadcaster_language"
            case broadcasterLogin = "broadcaster_login"
            case displayName = "display_name"
            case gameID = "game_id"
            case gameName = "game_name"
            case isLive = "is_live"
            case tagsIDS = "tags_ids"
            case thumbnailURL = "thumbnail_url"
            case startedAt = "started_at"
        }
    }
    
    func findChannels(query: String, after: String? = nil, first: Int? = nil, showLiveOnly: Bool? = nil, onCompletion: @escaping (Result<Paginated<ChannelSearchResponse>, TwitchAPIError>) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let encodedQuery = encodedQuery else {
            onCompletion(.failure(.invalidRequest))
            return
        }

        var parameters: [String: String] = [:]
        
        if let after = after {
            parameters["after"] = after
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        if let showLiveOnly = showLiveOnly {
            parameters["live_only"] = String(showLiveOnly)
        }
        
        requestAPI(endpoint: "search/channels?query=\(encodedQuery)", onCompletion: onCompletion)
    }
}
