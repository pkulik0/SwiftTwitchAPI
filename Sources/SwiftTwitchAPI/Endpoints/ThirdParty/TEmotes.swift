//
//  File.swift
//  
//
//  Created by pkulik0 on 27/07/2022.
//

public extension SwiftTwitchAPI {
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
