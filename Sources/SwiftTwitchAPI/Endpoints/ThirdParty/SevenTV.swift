//
//  SevenTV.swift
//  
//
//  Created by pkulik0 on 26/07/2022.
//

public extension SwiftTwitchAPI {
    struct SevenTVEmote: Codable {
        public let id: String
        public let name: String
        public let owner: Owner
        public let visibility: Int
        public let visibilitySimple: [String]?
        public let mime: String
        public let status: Int
        public let tags: [String]?
        public let width: [Int]
        public let height: [Int]
        public let urls: [[String]]

        enum CodingKeys: String, CodingKey {
            case id, name, owner, visibility, mime, status, tags, width, height, urls
            case visibilitySimple = "visibility_simple"
        }
        
        public struct Owner: Codable {
            public let id: String
            public let twitchID: String
            public let login: String
            public let displayName: String
            public let role: Role
            public let profilePictureID: String?

            enum CodingKeys: String, CodingKey {
                case id, login, role
                case twitchID = "twitch_id"
                case displayName = "display_name"
                case profilePictureID = "profile_picture_id"
            }
            
            public struct Role: Codable {
                public let id: String
                public let name: String
                public let position: Int
                public let color: Int
                public let allowed: Int
                public let denied: Int
            }
        }
    }
    
    func getSevenTVEmotes(channelID: String, onCompletion: @escaping (Result<[SevenTVEmote], APIError>) -> Void) {
        requestAPI(endpoint: "users/\(channelID)/emotes/", api: .SevenTV, onCompletion: onCompletion)
    }
}
