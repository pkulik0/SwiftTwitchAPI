//
//  Emotes.swift
//  
//
//  Created by pkulik0 on 09/07/2022.
//

public extension SwiftTwitchAPI {
    struct Emote: Codable, Identifiable {
        public let id: String
        public let name: String
        public let images: Image
        public let tier: String?
        public let emoteType: String?
        public let emoteSetID: String?
        public let format: [String]
        public let scale: [String]
        public let themeMode: [String]

        enum CodingKeys: String, CodingKey {
            case id, name, images, tier, format, scale
            case emoteType = "emote_type"
            case emoteSetID = "emote_set_id"
            case themeMode = "theme_mode"
        }
        
        public struct Image: Codable {
            public let url1X, url2X, url4X: String

            enum CodingKeys: String, CodingKey {
                case url1X = "url_1x"
                case url2X = "url_2x"
                case url4X = "url_4x"
            }
        }

    }
    
    func getTwitchChannelEmotes(broadcasterID: String, onCompletion: @escaping (Result<Paginated<Emote>, APIError>) -> Void) {
        requestAPI(endpoint: "chat/emotes?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    func getTwitchGlobalEmotes(onCompletion: @escaping (Result<Paginated<Emote>, APIError>) -> Void) {
        requestAPI(endpoint: "chat/emotes/global", onCompletion: onCompletion)
    }
    
    func getEmoteSets(emoteSetIDs: [String], onCompletion: @escaping (Result<Paginated<Emote>, APIError>) -> Void) {
        if emoteSetIDs.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        var endpoint = "chat/emotes/set?"
        emoteSetIDs.forEach({ endpoint.append("emote_set_id=\($0)&") })
        
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
