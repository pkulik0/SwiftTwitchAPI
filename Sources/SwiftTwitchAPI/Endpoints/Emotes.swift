//
//  Emotes.swift
//  
//
//  Created by pkulik0 on 09/07/2022.
//

public extension SwiftTwitchAPI {
    
    // First party Twitch emotes
    
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
    
    // Third party API with BTTV, FFZ and 7tv emotes
    
    struct TEmote: Codable {
        public let provider: Int
        public let code: String
        public let urls: [EmoteURL]
        
        public struct EmoteURL: Codable {
            public let size: Size
            public let url: String
            
            public enum Size: String, Codable {
                case the1X = "1x"
                case the2X = "2x"
                case the3X = "3x"
                case the4X = "4x"
            }
        }
    }

    func getAllGlobalEmotes(onCompletion: @escaping (Result<[TEmote], APIError>) -> Void) {
        requestAPI(endpoint: "global/emotes/all", api: .TEmotes, onCompletion: onCompletion)
    }
    
    func getAllChannelEmotes(channelID: String, onCompletion: @escaping (Result<[TEmote], APIError>) -> Void) {
        requestAPI(endpoint: "channel/\(channelID)/emotes/all", api: .TEmotes, onCompletion: onCompletion)
    }
}
