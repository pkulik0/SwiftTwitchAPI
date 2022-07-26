//
//  FFZ.swift
//  
//
//  Created by pkulik0 on 26/07/2022.
//

public extension SwiftTwitchAPI {
    struct FFZEmote: Codable {
        public let id: Int
        public let user: User
        public let code: String
        public let images: Images
        public let imageType: ImageType
        
        public struct Images: Codable {
            public let the1X: String
            public let the2X: String?
            public let the4X: String?

            enum CodingKeys: String, CodingKey {
                case the1X = "1x"
                case the2X = "2x"
                case the4X = "4x"
            }
        }
        
        public struct User: Codable {
            public let id: Int
            public let name: String
            public let displayName: String
        }
    }
    
    func getFFZEmotes(channelID: String, onCompletion: @escaping (Result<[FFZEmote], APIError>) -> Void) {
        requestAPI(endpoint: "frankerfacez/users/twitch/\(channelID)", api: .BetterTTV, onCompletion: onCompletion)
    }
}
