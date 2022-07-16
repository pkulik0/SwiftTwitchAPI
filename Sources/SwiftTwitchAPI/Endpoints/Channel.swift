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
        var endpoint = "channels?"
        for id in broadcasterIDs {
            endpoint += "broadcaster_id=\(id)&"
        }
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
}
