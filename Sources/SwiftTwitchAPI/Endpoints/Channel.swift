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
    
    func getChannelEditors(broadcasterID: String, onCompletion: @escaping (Result<[ChannelEditorResponse], TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "channels/editors?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    struct ChannelRewardResponse: Codable {
        let broadcasterID: String
        let broadcasterName: String
        let broadcasterName: String
        let id: String
        let title: String
        let prompt: String
        let cost: Int
        let backgroundColor: String
        let isEnabled: Bool
        let isUserInputRequired: Bool
        let isPaused: Bool
        let isInStock: Bool
        let shouldSkipQueue: Bool
        let redemptionsDuringCurrentStream: Int?
        let cooldownExpiryTimestamp: String?
        
        struct Image: Codable {
            let url_1x: String
            let url_2x: String
            let url_3x: String
        }
        
        let image: Image?
        let defaultImage: Image
        
        struct PerStreamCooldown: Codable {
            let isEnabled: Bool
            let length: Int
            
            enum CodingKeys: String, CodingKey {
                case isEnabled = "is_enabled"
                case length = "max_per_stream"
            }
        }
        
        struct PerUserPerStreamCooldown: Codable {
            let isEnabled: Bool
            let length: Int
            
            enum CodingKeys: String, CodingKey {
                case isEnabled = "is_enabled"
                case length = "max_per_user_per_stream"
            }
        }
        
        struct GlobalCooldown: Codable {
            let isEnabled: Bool
            let length: Int
            
            enum CodingKeys: String, CodingKey {
                case isEnabled = "is_enabled"
                case length = "global_cooldown_seconds"
            }
        }
        
        let maxPerStreamSettings: PerStreamCooldown
        let maxPerUserPerStreamSettigs: PerUserPerStreamCooldown
        let globalCooldownSettings: GlobalCooldown
        
        struct CodingKeys: String, CodingKey {
            case id, title, prompt, image
            case broadcasterID = "broadcaster_id"
            case broadcasterName = "broadcaster_name"
            case defaultImage = "default_image"
            case backgroundColor = "background_color"
            case isEnabled = "is_enabled"
            case isUserInputRequired = "is_user_input_required"
            case isPaused = "is_paused"
            case isInStock = "is_in_stock"
            case shouldSkipQueue = "should_redemptions_skip_request_queue"
            case redemptionsDuringCurrentStream = "redemptions_redeemed_current_stream"
            case cooldownExpiryTimestamp = "cooldown_expires_at"
            case maxPerStreamSettings = "max_per_stream_setting"
            case maxPerUserPerStreamSettigs = "max_per_user_per_stream_setting"
            case globalCooldownSettings = "global_cooldown_setting"
        }
    }
    
    func createChannelReward(broadcasterID: String, title: String, cost: Int, prompt: String?, isEnabled: Bool?, backgroundColor: String?, isUserInputRequired: Bool?, isMaxPerStreamEnabled: Bool?, maxPerStream: Int?, isMaxPerUserPerStreamEnabled: Bool?, maxPerUserPerStream: Int?, isGlobalCooldownEnabled: Bool?, globalCooldown: Int?, shouldSkipQueue: Bool?, onCompletion: @escaping (Result<[ChannelRewardResponse], TwitchAPIError>) -> Void) {
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
}
