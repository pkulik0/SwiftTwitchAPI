//
//  Badges.swift
//  
//
//  Created by pkulik0 on 09/07/2022.
//

public extension SwiftTwitchAPI {
    struct BadgeResponse: Codable {
        public let setID: String
        public let versions: [Version]

        enum CodingKeys: String, CodingKey {
            case setID = "set_id"
            case versions
        }
        
        public struct Version: Codable {
            public let id: String
            public let imageURL1X, imageURL2X, imageURL4X: String

            enum CodingKeys: String, CodingKey {
                case id
                case imageURL1X = "image_url_1x"
                case imageURL2X = "image_url_2x"
                case imageURL4X = "image_url_4x"
            }
        }
    }
    
    func getChannelBadges(broadcasterID: String, onCompletion: @escaping (Result<Paginated<BadgeResponse>, TwitchAPIError>) -> Void) {
        requestTwitchAPI(endpoint: "chat/badges?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    func getGlobalBadges(onCompletion: @escaping (Result<Paginated<BadgeResponse>, TwitchAPIError>) -> Void) {
        requestTwitchAPI(endpoint: "chat/badges/global", onCompletion: onCompletion)
    }
}
