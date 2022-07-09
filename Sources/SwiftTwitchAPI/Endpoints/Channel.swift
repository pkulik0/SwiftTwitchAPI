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
    
    func getChannel(broadcasterIDs: [String], onCompletion: @escaping (Result<Paginated<[ChannelResponse]>, TwitchAPIError>) -> Void) {
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
    
    func getChannelEditors(broadcasterID: String, onCompletion: @escaping (Result<Paginated<[ChannelEditorResponse]>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "channels/editors?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    struct ChannelRewardResponse: Codable {
        let broadcasterName: String
        let broadcasterLogin: String
        let broadcasterID: String
        let id: String
        let title: String
        let prompt: String
        let cost: Int
        let image: Image?
        let defaultImage: Image
        let backgroundColor: String
        let isEnabled: Bool
        let isPaused: Bool
        let isInStock: Bool
        let isUserInputRequired: Bool
        let maxPerStreamSetting: MaxPerStreamSetting
        let maxPerUserPerStreamSetting: MaxPerUserPerStreamSetting
        let globalCooldownSetting: GlobalCooldownSetting
        let shouldRedemptionsSkipRequestQueue: Bool
        let redemptionsRedeemedCurrentStream: Int?
        let cooldownExpiresAt: String?

        enum CodingKeys: String, CodingKey {
            case id, title, cost, prompt, image
            case broadcasterName = "broadcaster_name"
            case broadcasterLogin = "broadcaster_login"
            case broadcasterID = "broadcaster_id"
            case backgroundColor = "background_color"
            case isEnabled = "is_enabled"
            case isUserInputRequired = "is_user_input_required"
            case maxPerStreamSetting = "max_per_stream_setting"
            case maxPerUserPerStreamSetting = "max_per_user_per_stream_setting"
            case globalCooldownSetting = "global_cooldown_setting"
            case isPaused = "is_paused"
            case isInStock = "is_in_stock"
            case defaultImage = "default_image"
            case shouldRedemptionsSkipRequestQueue = "should_redemptions_skip_request_queue"
            case redemptionsRedeemedCurrentStream = "redemptions_redeemed_current_stream"
            case cooldownExpiresAt = "cooldown_expires_at"
        }
        
        struct Image: Codable {
            let url1X, url2X, url4X: String

            enum CodingKeys: String, CodingKey {
                case url1X = "url_1x"
                case url2X = "url_2x"
                case url4X = "url_4x"
            }
        }

        struct GlobalCooldownSetting: Codable {
            let isEnabled: Bool
            let globalCooldownSeconds: Int

            enum CodingKeys: String, CodingKey {
                case isEnabled = "is_enabled"
                case globalCooldownSeconds = "global_cooldown_seconds"
            }
        }

        struct MaxPerStreamSetting: Codable {
            let isEnabled: Bool
            let maxPerStream: Int

            enum CodingKeys: String, CodingKey {
                case isEnabled = "is_enabled"
                case maxPerStream = "max_per_stream"
            }
        }

        struct MaxPerUserPerStreamSetting: Codable {
            let isEnabled: Bool
            let maxPerUserPerStream: Int

            enum CodingKeys: String, CodingKey {
                case isEnabled = "is_enabled"
                case maxPerUserPerStream = "max_per_user_per_stream"
            }
        }
    }
    
    func createChannelReward(broadcasterID: String, title: String, cost: Int, prompt: String? = nil, isEnabled: Bool? = nil, backgroundColor: String? = nil, isUserInputRequired: Bool? = nil, isMaxPerStreamEnabled: Bool? = nil, maxPerStream: Int? = nil, isMaxPerUserPerStreamEnabled: Bool? = nil, maxPerUserPerStream: Int? = nil, isGlobalCooldownEnabled: Bool? = nil, globalCooldown: Int? = nil, shouldSkipQueue: Bool? = nil, onCompletion: @escaping (Result<Paginated<[ChannelRewardResponse]>, TwitchAPIError>) -> Void) {
        var requestBody: [String: Any] = [:]
        requestBody["title"] = title
        requestBody["cost"] = cost
        
        if let prompt = prompt {
            requestBody["prompt"] = prompt
        }
        if let isEnabled = isEnabled {
            requestBody["is_enabled"] = isEnabled
        }
        if let backgroundColor = backgroundColor {
            requestBody["background_color"] = backgroundColor
        }
        if let isUserInputRequired = isUserInputRequired {
            requestBody["is_user_input_required"] = isUserInputRequired
        }
        if let isMaxPerStreamEnabled = isMaxPerStreamEnabled, let maxPerStream = maxPerStream {
            requestBody["is_max_per_stream_enabled"] = isMaxPerStreamEnabled
            requestBody["max_per_stream"] = maxPerStream
        }
        if let isMaxPerUserPerStreamEnabled = isMaxPerUserPerStreamEnabled, let maxPerUserPerStream = maxPerUserPerStream {
            requestBody["is_max_per_user_per_stream_enabled"] = isMaxPerUserPerStreamEnabled
            requestBody["max_per_user_per_stream"] = maxPerUserPerStream
        }
        if let isGlobalCooldownEnabled = isGlobalCooldownEnabled, let globalCooldown = globalCooldown {
            requestBody["is_global_cooldown_enabled"] = isGlobalCooldownEnabled
            requestBody["global_cooldown_seconds"] = globalCooldown
        }
        if let shouldSkipQueue = shouldSkipQueue {
            requestBody["should_redemptions_skip_request_queue"] = shouldSkipQueue
        }
        
        requestAPI(endpoint: "channel_points/custom_rewards?broadcaster_id=\(broadcasterID)", requestMethod: .POST, requestBody: requestBody, onCompletion: onCompletion)
    }
    
    func removeChannelReward(broadcasterID: String, rewardID: String, onCompletion: @escaping (Result<Int, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "channel_points/custom_rewards?broadcaster_id=\(broadcasterID)&id=\(rewardID)", requestMethod: .DELETE, onCompletion: onCompletion)
    }
    
    func getChannelRewards(broadcasterID: String, onlyManagable: Bool = false, onCompletion: @escaping (Result<Paginated<[ChannelRewardResponse]>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "channel_points/custom_rewards?broadcaster_id=\(broadcasterID)&only_manageable_rewards=\(onlyManagable)", onCompletion: onCompletion)
    }
}
