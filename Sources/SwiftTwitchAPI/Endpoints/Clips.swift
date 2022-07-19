//
//  Clips.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

public extension SwiftTwitchAPI {
    struct NewClipResponse: Codable {
        public let id: String
        public let editUrl: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case editUrl = "edit_url"
        }
    }
    
    func createClip(broadcasterID: String, hasDelay: Bool = false, onCompletion: @escaping (Result<Paginated<NewClipResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "clips?broadcaster_id=\(broadcasterID)&has_delay=\(hasDelay)", requestMethod: .POST, onCompletion: onCompletion)
    }
    
    struct ClipResponse: Codable {
        public let id: String
        public let url: String
        public let embedURL: String
        public let broadcasterID: String
        public let broadcasterName: String
        public let creatorID: String
        public let creatorName: String
        public let videoID: String
        public let gameID: String
        public let language: String
        public let title: String
        public let viewCount: Int
        public let createdAt: String
        public let thumbnailURL: String
        public let duration: Double

        enum CodingKeys: String, CodingKey {
            case id, url, language, title, duration
            case embedURL = "embed_url"
            case broadcasterID = "broadcaster_id"
            case broadcasterName = "broadcaster_name"
            case creatorID = "creator_id"
            case creatorName = "creator_name"
            case videoID = "video_id"
            case gameID = "game_id"
            case viewCount = "view_count"
            case createdAt = "created_at"
            case thumbnailURL = "thumbnail_url"
        }
    }
    
    func getClips(broadcasterID: String, after: String? = nil, before: String? = nil, startedAt: String? = nil, endedAt: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<ClipResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "clips?broadcaster_id=\(broadcasterID)", requestMethod: .GET, onCompletion: onCompletion)
    }
    
    func getClips(gameID: String, after: String? = nil, before: String? = nil, startedAt: String? = nil, endedAt: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<ClipResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "clips?game_id=\(gameID)", requestMethod: .GET, onCompletion: onCompletion)
    }
    
    func getClips(clipIDs: [String], after: String? = nil, before: String? = nil, startedAt: String? = nil, endedAt: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<ClipResponse>, TwitchAPIError>) -> Void) {
        if clipIDs.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        var endpoint = "clips?"
        clipIDs.forEach({ endpoint.append("id=\($0)&") })
        
        requestAPI(endpoint: endpoint, requestMethod: .GET, onCompletion: onCompletion)
    }
}
