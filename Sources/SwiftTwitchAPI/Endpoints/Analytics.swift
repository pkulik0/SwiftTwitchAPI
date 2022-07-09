//
//  Analytics.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

import Foundation

extension SwiftTwitchAPI {
    struct ExtensionAnalyticsResponse: Codable {
        let extensionID: String
        let dateRange: DateRange
        let type: String
        let url: String
        
        enum CodingKeys: String, CodingKey {
            case extensionID = "extension_id"
            case dateRange = "date_range"
            case type
            case url
        }
    }
    
    struct GameAnalyticsResponse: Codable {
        let gameID: String
        let dateRange: DateRange
        let type: String
        let url: String
        
        enum CodingKeys: String, CodingKey {
            case gameID = "game_id"
            case dateRange = "date_range"
            case type
            case url
        }
    }
    
    func getExtensionsAnalytics(after: String? = nil, startedAt: String? = nil, endedAt: String? = nil, extensionID: String? = nil, first: Int? = nil, type: String? = nil, onCompletion: @escaping (Result<Paginated<ExtensionAnalyticsResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        if let after = after {
            parameters["after"] = after
        }
        if let startedAt = startedAt {
            parameters["started_at"] = startedAt
        }
        if let endedAt = endedAt {
            parameters["ended_at"] = endedAt
        }
        if let extensionID = extensionID {
            parameters["extension_id"] = extensionID
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        if let type = type {
            parameters["type"] = type
        }
        
        let endpoint = appendParameters(parameters, to: "analytics/extensions")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
    
    func getGamesAnalytics(after: String? = nil, startedAt: String? = nil, endedAt: String? = nil, gameID: String? = nil, first: Int? = nil, type: String? = nil, onCompletion: @escaping (Result<Paginated<GameAnalyticsResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        if let after = after {
            parameters["after"] = after
        }
        if let startedAt = startedAt {
            parameters["started_at"] = startedAt
        }
        if let endedAt = endedAt {
            parameters["ended_at"] = endedAt
        }
        if let gameID = gameID {
            parameters["game_id"] = gameID
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        if let type = type {
            parameters["type"] = type
        }
        
        let endpoint = appendParameters(parameters, to: "analytics/games")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
