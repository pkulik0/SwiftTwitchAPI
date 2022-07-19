//
//  Chat.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

public extension SwiftTwitchAPI {
    struct ChatSettingsResponse: Codable {
        public let broadcasterID: String
        public let isInSlowMode: Bool
        public let slowModeWaitTime: Int?
        public let isInFollowerMode: Bool
        public let followerModeDuration: Int?
        public let isInSubscriberMode: Bool
        public let isInEmoteMode: Bool
        public let isInUniqueChatMode: Bool
        public let isNonModeratorChatDelayEnabled: Bool?
        public let nonModeratorChatDelayDuration: Int?

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
    
    struct ChatColorResponse: Codable {
        public let userID: String
        public let userName: String
        public let userLogin: String
        public let color: String

        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case userName = "user_name"
            case userLogin = "user_login"
            case color
        }
    }


    func getChatColor(userIDs: [String], onCompletion: @escaping (Result<Paginated<ChatColorResponse>,TwitchAPIError>) -> Void) {
        if userIDs.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        var endpoint = "chat/color?"
        userIDs.forEach({ endpoint.append("user_id=\($0)&") })
        
        requestAPI(endpoint: endpoint, requestMethod: .GET, onCompletion: onCompletion)
    }
    
    enum ChatColor: String, Codable {
        case blue, chocolate, coral, firebrick, green, red
        case blueViolet = "blue_violet"
        case cadetBlue = "cadet_blue"
        case dodgerBlue = "dodger_blue"
        case goldenRod = "golden_rod"
        case hotPink = "hot_pink"
        case orangeRed = "orange_red"
        case seaGreen = "sea_green"
        case springGreen = "spring_green"
        case yellowGreen = "yellow_green"
    }
    
    func updateChatColor(userID: String, color: ChatColor, onCompletion: @escaping (Result<Int, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "chat/color?user_id=\(userID)&color=\(color.rawValue)", requestMethod: .PUT, onCompletion: onCompletion)
    }
}
