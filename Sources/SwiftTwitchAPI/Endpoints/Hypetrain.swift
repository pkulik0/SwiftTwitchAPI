//
//  Hypetrain.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

extension SwiftTwitchAPI {
    struct ChannelHypetrainResponse: Codable {
        let id: String
        let eventType: String
        let eventTimestamp: String
        let version: String
        let eventData: EventData

        enum CodingKeys: String, CodingKey {
            case id, version
            case eventType = "event_type"
            case eventTimestamp = "event_timestamp"
            case eventData = "event_data"
        }
        
        struct Contribution: Codable {
            let total: Int
            let type: String
            let user: String
        }
        
        struct EventData: Codable {
            let broadcasterID: String
            let cooldownEndTime: String
            let expiresAt: String
            let goal: Int
            let id: String
            let level: Int
            let total: Int
            let startedAt: String
            let lastContribution: Contribution
            let topContributions: [Contribution]
            
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
    
    func getHypetrainInformation(broadcasterID: String, first: Int? = nil, cursor: String? = nil, onCompletion: @escaping (Result<Paginated<ChannelHypetrainResponse>, TwitchAPIError>) -> Void) {
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
