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
    
    struct ChatSettingsResponse: Codable {
        let broadcasterID: String
        let isInSlowMode: Bool
        let slowModeWaitTime: Int?
        let isInFollowerMode: Bool
        let followerModeDuration: Int?
        let isInSubscriberMode: Bool
        let isInEmoteMode: Bool
        let isInUniqueChatMode: Bool
        let isNonModeratorChatDelayEnabled: Bool?
        let nonModeratorChatDelayDuration: Int?

        enum CodingKeys: String, CodingKey {
            case broadcasterID = "broadcaster_id"
            case isInSlowMode = "slow_mode"
            case slowModeWaitTime = "slow_mode_wait_time"
            case isInFollowerMode = "follower_mode"
            case followerModeDuration = "follower_mode_duration"
            case isInSubscriberMode = "subscriber_mode"
            case isInEmoteMode = "emote_mode"
            case isInUniqueChatMode = "unique_chat_mode"
            case isNonModeratorChatDelayEnabled = "non_moderator_chat_delay"
            case nonModeratorChatDelayDuration = "non_moderator_chat_delay_duration"
        }
    }
    
    func getChatSettings(broadcasterID: String, moderatorID: String? = nil, onCompletion: @escaping (Result<Paginated<ChatSettingsResponse>, TwitchAPIError>) -> Void) {
        var endpoint = "chat/settings?broadcaster_id=\(broadcasterID)"
        if let moderatorID = moderatorID {
            endpoint += "&moderator_id=\(moderatorID)"
        }
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
    
    func updateChatSettings(broadcasterID: String, moderatorID: String, isInEmoteMode: Bool? = nil, isInFollowerMode: Bool? = nil, followerModeDuration: Int? = nil, isInSlowMode: Bool? = nil, slowModeWaitTime: Int? = nil, isInSubscriberMode: Bool? = nil, isInUniqueChatMode: Bool? = nil, isNonModeratorChatDelayEnabled: Bool? = nil, nonModeratorChatDelayDuration: Int? = nil, onCompletion: @escaping (Result<Paginated<ChatSettingsResponse>, TwitchAPIError>) -> Void) {
        var requestBody: [String: Any] = [:]
        
        if let isInEmoteMode = isInEmoteMode {
            requestBody["emote_mode"] = isInEmoteMode
        }
        if let isInFollowerMode = isInFollowerMode {
            requestBody["follower_mode"] = isInFollowerMode
        }
        if let followerModeDuration = followerModeDuration {
            requestBody["follower_mode_duration"] = followerModeDuration
        }
        if let isInSlowMode = isInSlowMode {
            requestBody["slow_mode"] = isInSlowMode
        }
        if let slowModeWaitTime = slowModeWaitTime {
            requestBody["slow_mode_wait_time"] = slowModeWaitTime
        }
        if let isInSubscriberMode = isInSubscriberMode {
            requestBody["subscriber_mode"] = isInSubscriberMode
        }
        if let isInUniqueChatMode = isInUniqueChatMode {
            requestBody["unique_chat_mode"] = isInUniqueChatMode
        }
        if let isNonModeratorChatDelayEnabled = isNonModeratorChatDelayEnabled {
            requestBody["non_moderator_chat_delay"] = isNonModeratorChatDelayEnabled
        }
        if let nonModeratorChatDelayDuration = nonModeratorChatDelayDuration {
            requestBody["non_moderator_chat_delay_duration"] = nonModeratorChatDelayDuration
        }
        
        if requestBody.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        requestAPI(endpoint: "chat/settings?broadcaster_id=\(broadcasterID)&moderator_id=\(moderatorID)", requestMethod: .PATCH, requestBody: requestBody, onCompletion: onCompletion)
    }
}
