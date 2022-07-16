//
//  Chat.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

extension SwiftTwitchAPI {
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
    
    enum AnnouncementColor: String, Codable {
        case primary, blue, green, orange, purple
    }
    
    func sendChatAnnouncement(broadcasterID: String, moderatorID: String, message: String, color: AnnouncementColor? = nil, onCompletion: @escaping (Result<Int, TwitchAPIError>) -> Void) {
        var requestBody: [String: Any] = [:]
        requestBody["message"] = message
        
        if let color = color {
            requestBody["color"] = color.rawValue
        }

        requestAPI(endpoint: "chat/announcements?broadcaster_id=\(broadcasterID)&moderator_id=\(moderatorID)", requestMethod: .POST, requestBody: requestBody, onCompletion: onCompletion)
    }
}
