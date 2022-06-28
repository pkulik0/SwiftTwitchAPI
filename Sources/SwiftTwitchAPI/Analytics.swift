//
//  Analytics.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

import Foundation

extension SwiftTwitchAPI {
    struct ExtensionAnalyticsResponse: Codable {
        let extension_id: String
        let date_range: DateRange
        let type: String
        let url: String
    }
    
    struct GameAnalyticsResponse: Codable {
        let game_id: String
        let date_range: DateRange
        let type: String
        let url: String
    }
    
    func getExtensionsAnalytics(after: String? = nil, started_at: String? = nil, ended_at: String? = nil, extension_id: String? = nil, first: Int? = nil, type: String? = nil, onCompletion: @escaping (Result<Paginated<[ExtensionAnalyticsResponse]>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        if let after = after {
            parameters["after"] = after
        }
        if let started_at = started_at {
            parameters["started_at"] = started_at
        }
        if let extension_id = extension_id {
            parameters["extension_id"] = extension_id
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
    
    func getGamesAnalytics(after: String? = nil, started_at: String? = nil, ended_at: String? = nil, game_id: String? = nil, first: Int? = nil, type: String? = nil, onCompletion: @escaping (Result<Paginated<[GameAnalyticsResponse]>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        if let after = after {
            parameters["after"] = after
        }
        if let started_at = started_at {
            parameters["started_at"] = started_at
        }
        if let game_id = game_id {
            parameters["game_id"] = game_id
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
