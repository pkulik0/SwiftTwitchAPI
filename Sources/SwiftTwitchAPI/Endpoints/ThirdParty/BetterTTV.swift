//
//  BetterTTV.swift
//  
//
//  Created by pkulik0 on 25/07/2022.
//

public extension SwiftTwitchAPI {
    struct BttvEmote: Codable {
        public let id: String
        public let code: String
        public let imageType: ImageType
        public let userID: String?
        public let user: User?

        public func getUrlString(size: Size) -> String {
            return "https://cdn.betterttv.net/emote/\(id)/\(size.rawValue)"
        }
        
        enum CodingKeys: String, CodingKey {
            case id, code, imageType, user
            case userID = "userId"
        }
        
        enum Size: String {
            case the1X = "1x"
            case the2X = "2x"
            case the3X = "3x"
        }
        
        public struct User: Codable {
            public let id: String
            public let name: String
            public let displayName: String
            public let providerID: String?

            enum CodingKeys: String, CodingKey {
                case id, name, displayName
                case providerID = "providerId"
            }
        }
    }
    
    enum ImageType: String, Codable {
        case gif, png
    }
    
    struct BttvChannelData: Codable {
        public let id: String
        public let bots: [String]
        public let avatar: String
        public let channelEmotes: [BttvEmote]
        public let sharedEmotes: [BttvEmote]
    }
    
    func getBttvGlobalEmotes(onCompletion: @escaping (Result<[BttvEmote], APIError>) -> Void) {
        requestAPI(endpoint: "emotes/global", api: .BetterTTV, onCompletion: onCompletion)
    }
    
    func getBttvChannelData(channelID: String, onCompletion: @escaping (Result<BttvChannelData, APIError>) -> Void) {
        requestAPI(endpoint: "users/twitch/\(channelID)", api: .BetterTTV, onCompletion: onCompletion)
    }
}
