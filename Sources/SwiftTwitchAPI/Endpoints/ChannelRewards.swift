//
//  ChannelRewards.swift
//  
//
//  Created by pkulik0 on 09/07/2022.
//

extension SwiftTwitchAPI {
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
    
    fileprivate func getChannelRewardRequestBody(title: String?, cost: Int?, prompt: String? = nil, isEnabled: Bool? = nil, backgroundColor: String? = nil, isUserInputRequired: Bool? = nil, isMaxPerStreamEnabled: Bool? = nil, maxPerStream: Int? = nil, isMaxPerUserPerStreamEnabled: Bool? = nil, maxPerUserPerStream: Int? = nil, isGlobalCooldownEnabled: Bool? = nil, globalCooldown: Int? = nil, shouldSkipQueue: Bool? = nil) -> [String: Any] {
        var requestBody: [String: Any] = [:]
        
        if let title = title {
            requestBody["title"] = title
        }
        if let cost = cost {
            requestBody["cost"] = cost
        }
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
        return requestBody
    }
    
    func createChannelReward(broadcasterID: String, title: String, cost: Int, prompt: String? = nil, isEnabled: Bool? = nil, backgroundColor: String? = nil, isUserInputRequired: Bool? = nil, isMaxPerStreamEnabled: Bool? = nil, maxPerStream: Int? = nil, isMaxPerUserPerStreamEnabled: Bool? = nil, maxPerUserPerStream: Int? = nil, isGlobalCooldownEnabled: Bool? = nil, globalCooldown: Int? = nil, shouldSkipQueue: Bool? = nil, onCompletion: @escaping (Result<Paginated<ChannelRewardResponse>, TwitchAPIError>) -> Void) {
        let requestBody = getChannelRewardRequestBody(title: title, cost: cost, prompt: prompt, isEnabled: isEnabled, backgroundColor: backgroundColor, isUserInputRequired: isUserInputRequired, isMaxPerStreamEnabled: isMaxPerStreamEnabled, maxPerStream: maxPerStream, isMaxPerUserPerStreamEnabled: isMaxPerStreamEnabled, maxPerUserPerStream: maxPerUserPerStream, isGlobalCooldownEnabled: isGlobalCooldownEnabled, globalCooldown: globalCooldown, shouldSkipQueue: shouldSkipQueue)
        
        requestAPI(endpoint: "channel_points/custom_rewards?broadcaster_id=\(broadcasterID)", requestMethod: .POST, requestBody: requestBody, onCompletion: onCompletion)
    }
    
    func updateChannelReward(broadcasterID: String, rewardID: String, title: String? = nil, cost: Int? = nil, prompt: String? = nil, isEnabled: Bool? = nil, backgroundColor: String? = nil, isUserInputRequired: Bool? = nil, isMaxPerStreamEnabled: Bool? = nil, maxPerStream: Int? = nil, isMaxPerUserPerStreamEnabled: Bool? = nil, maxPerUserPerStream: Int? = nil, isGlobalCooldownEnabled: Bool? = nil, globalCooldown: Int? = nil, shouldSkipQueue: Bool? = nil, onCompletion: @escaping (Result<Paginated<ChannelRewardResponse>, TwitchAPIError>) -> Void) {
        let requestBody = getChannelRewardRequestBody(title: title, cost: cost, prompt: prompt, isEnabled: isEnabled, backgroundColor: backgroundColor, isUserInputRequired: isUserInputRequired, isMaxPerStreamEnabled: isMaxPerStreamEnabled, maxPerStream: maxPerStream, isMaxPerUserPerStreamEnabled: isMaxPerStreamEnabled, maxPerUserPerStream: maxPerUserPerStream, isGlobalCooldownEnabled: isGlobalCooldownEnabled, globalCooldown: globalCooldown, shouldSkipQueue: shouldSkipQueue)
        
        if requestBody.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }

        requestAPI(endpoint: "channel_points/custom_rewards?broadcaster_id=\(broadcasterID)&id=\(rewardID)", requestMethod: .PATCH, requestBody: requestBody, onCompletion: onCompletion)
    }
    
    func removeChannelReward(broadcasterID: String, rewardID: String, onCompletion: @escaping (Result<Int, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "channel_points/custom_rewards?broadcaster_id=\(broadcasterID)&id=\(rewardID)", requestMethod: .DELETE, onCompletion: onCompletion)
    }
    
    func getChannelRewards(broadcasterID: String, onlyManagable: Bool = false, onCompletion: @escaping (Result<Paginated<ChannelRewardResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "channel_points/custom_rewards?broadcaster_id=\(broadcasterID)&only_manageable_rewards=\(onlyManagable)", onCompletion: onCompletion)
    }
    
    struct ChannelRewardRedemptionResponse: Codable {
        let broadcasterName: String
        let broadcasterLogin: String
        let broadcasterID: String
        let userLogin: String
        let userName: String
        let userID: String
        let userInput: String
        let id: String
        let status: Status
        let redeemedAt: String
        let reward: Reward

        enum CodingKeys: String, CodingKey {
            case id, status, reward
            case broadcasterName = "broadcaster_name"
            case broadcasterLogin = "broadcaster_login"
            case broadcasterID = "broadcaster_id"
            case userLogin = "user_login"
            case userID = "user_id"
            case userName = "user_name"
            case userInput = "user_input"
            case redeemedAt = "redeemed_at"
        }
        
        enum Status: String, Codable {
            case unfulfilled = "UNFULFILLED"
            case fulfilled = "FULFILLED"
            case cancelled = "CANCELLED"
        }
        
        enum SortType: String, Codable {
            case oldToNew = "OLDEST"
            case newToOld = "NEWEST"
        }
        
        struct Reward: Codable {
            let id: String
            let title: String
            let prompt: String
            let cost: Int
        }
    }
    
    func getChannelRewardRedemption(broadcasterID: String, rewardID: String, redemptionID: [String]? = nil, status: ChannelRewardRedemptionResponse.Status? = nil, sort: ChannelRewardRedemptionResponse.SortType? = nil, after: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<ChannelRewardRedemptionResponse>, TwitchAPIError>) -> Void) {
        if status == nil && redemptionID == nil {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        var parameters: [String: String] = [:]
        
        if let redemptionID = redemptionID {
            parameters["id"] = redemptionID.joined(separator: ",")
        }
        if let status = status {
            parameters["status"] = status.rawValue
        }
        if let sort = sort {
            parameters["sort"] = sort.rawValue
        }
        if let after = after {
            parameters["after"] = after
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        
        parameters["broadcaster_id"] = broadcasterID
        parameters["reward_id"] = rewardID
        
        let endpoint = appendParameters(parameters, to: "channel_points/custom_rewards/redemptions")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
    
    func updateChannelRewardRedemption(broadcasterID: String, rewardID: String, redemptionID: [String], status: ChannelRewardRedemptionResponse.Status, onCompletion: @escaping (Result<Paginated<ChannelRewardRedemptionResponse>, TwitchAPIError>) -> Void) {
        var requestBody: [String: Any] = [:]
        requestBody["status"] = status
        
        let ids = redemptionID.joined(separator: ",")
        requestAPI(endpoint: "channel_points/custom_rewards/redemptions?broadcaster_id=\(broadcasterID)&reward_id=\(rewardID)&id=\(ids)", requestMethod: .PATCH, requestBody: requestBody, onCompletion: onCompletion)
    }
}
