//
//  Channels.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

public extension SwiftTwitchAPI {
    struct Channel: Codable {
        public let broadcasterID: String
        public let broadcasterLogin: String
        public let broadcasterName: String 
        public let broadcasterLanguage: String
        
        public let gameName: String
        public let gameID: String
        
        public let title: String
        public let delay: Int
        
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
    
    func getChannel(broadcasterIDs: [String], onCompletion: @escaping (Result<Paginated<Channel>, APIError>) -> Void) {
        if broadcasterIDs.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        var endpoint = "channels?"
        broadcasterIDs.forEach({ endpoint.append("broadcaster_id=\($0)&") })

        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }

    func modifyChannel(broadcasterID: String, gameID: String? = nil, broadcasterLanguage: String? = nil, title: String? = nil, delay: Int? = nil, onCompletion: @escaping (Result<Int, APIError>) -> Void) {
        
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
        public let userID: String
        public let userName: String
        public let createdAt: String
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case userName = "user_name"
            case createdAt = "created_at"
        }
    }
    
    func getChannelEditors(broadcasterID: String, onCompletion: @escaping (Result<Paginated<ChannelEditorResponse>, APIError>) -> Void) {
        requestAPI(endpoint: "channels/editors?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    struct CreatorGoalResponse: Codable {
        public let id: String
        public let broadcasterID: String
        public let broadcasterName: String
        public let broadcasterLogin: String
        public let type: String
        public let welcomeDescription: String
        public let currentAmount: Int
        public let targetAmount: Int
        public let createdAt: String

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
    
    func getCreatorGoals(broadcasterID: String, onCompletion: @escaping (Result<Paginated<CreatorGoalResponse>, APIError>) -> Void) {
        requestAPI(endpoint: "goals?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    struct ChannelSearchResponse: Codable {
        public let broadcasterLanguage: String
        public let broadcasterLogin: String
        public let displayName: String
        public let gameID: String
        public let gameName: String
        public let id: String
        public let isLive: Bool
        public let tagsIDS: [String]?
        public let thumbnailURL: String
        public let title: String
        public let startedAt: String?

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
    
    func findChannels(query: String, after: String? = nil, first: Int? = nil, showLiveOnly: Bool? = nil, onCompletion: @escaping (Result<Paginated<ChannelSearchResponse>, APIError>) -> Void) {
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
    
    struct ChannelHypetrainResponse: Codable {
        public let id: String
        public let eventType: String
        public let eventTimestamp: String
        public let version: String
        public let eventData: EventData

        enum CodingKeys: String, CodingKey {
            case id, version
            case eventType = "event_type"
            case eventTimestamp = "event_timestamp"
            case eventData = "event_data"
        }
        
        public struct Contribution: Codable {
            public let total: Int
            public let type: String
            public let user: String
        }
        
        public struct EventData: Codable {
            public let broadcasterID: String
            public let cooldownEndTime: String
            public let expiresAt: String
            public let goal: Int
            public let id: String
            public let level: Int
            public let total: Int
            public let startedAt: String
            public let lastContribution: Contribution
            public let topContributions: [Contribution]
            
            enum CodingKeys: String, CodingKey {
                case goal, id, level, total
                case broadcasterID = "broadcaster_id"
                case cooldownEndTime = "cooldown_end_time"
                case expiresAt = "expires_at"
                case lastContribution = "last_contribution"
                case startedAt = "started_at"
                case topContributions = "top_contributions"
            }
        }
    }
    
    func getHypetrainInformation(broadcasterID: String, first: Int? = nil, cursor: String? = nil, onCompletion: @escaping (Result<Paginated<ChannelHypetrainResponse>, APIError>) -> Void) {
        var parameters: [String: String] = [:]
        
        if let first = first {
            parameters["first"] = String(first)
        }
        if let cursor = cursor {
            parameters["cursor"] = cursor
        }
        
        let endpoint = appendParameters(parameters, to: "hypetrain/events?broadcaster_id=\(broadcasterID)")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
