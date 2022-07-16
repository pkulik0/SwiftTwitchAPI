//
//  Emotes.swift
//  
//
//  Created by pkulik0 on 09/07/2022.
//

extension SwiftTwitchAPI {
    struct EmotesResponse: Codable {
        let id: String
        let name: String
        let images: Image
        let tier: String
        let emoteType: String
        let emoteSetID: String
        let format: [String]
        let scale: [String]
        let themeMode: [String]

        enum CodingKeys: String, CodingKey {
            case id, name, images, tier, format, scale
            case emoteType = "emote_type"
            case emoteSetID = "emote_set_id"
            case themeMode = "theme_mode"
        }
        
        struct Image: Codable {
            let url1X, url2X, url4X: String

            enum CodingKeys: String, CodingKey {
                case url1X = "url_1x"
                case url2X = "url_2x"
                case url4X = "url_4x"
            }
        }

    }
    
    func getChannelEmotes(broadcasterID: String, onCompletion: @escaping (Result<Paginated<EmotesResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "chat/emotes?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    func getGlobalEmotes(onCompletion: @escaping (Result<Paginated<EmotesResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "chat/emotes/global", onCompletion: onCompletion)
    }
    
    func getEmoteSets(emoteSetIDs: [String], onCompletion: @escaping (Result<Paginated<EmotesResponse>, TwitchAPIError>) -> Void) {
        if emoteSetIDs.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        var endpoint = "chat/emotes/set?"
        emoteSetIDs.forEach({ endpoint.append("emote_set_id=\($0)&") })
        
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
