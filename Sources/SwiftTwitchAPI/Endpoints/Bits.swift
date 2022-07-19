//
//  Bits.swift
//  
//
//  Created by pkulik0 on 29/06/2022.
//

public extension SwiftTwitchAPI {
    struct BitsLeaderboardResponse: Codable {
        public let user_id: String
        public let user_login: String
        public let user_name: String
        
        public let rank: Int
        public let score: Int
        public let total: Int

        public let dateRange: DateRange
        
        public struct DateRange: Codable {
            public let endedAt: String
            public let startedAt: String
            
            enum CodingKeys: String, CodingKey {
                case endedAt = "ended_at"
                case startedAt = "started_at"
            }
        }
    }
    
    struct BitsCheermoteResponse: Codable {
        public let lastUpdated: String
        public let order: Int
        public let prefix: String
        public let type: TypeEnum
        public let isCharitable: Bool
        public let tiers: [Tier]

        enum CodingKeys: String, CodingKey {
            case lastUpdated = "last_updated"
            case order
            case prefix
            case type
            case isCharitable = "is_charitable"
            case tiers
        }
        
        public enum TypeEnum: String, Codable {
            case globalFirstParty = "global_first_party"
            case globalThirdParty = "global_third_party"
            case displayOnly = "display_only"
            case channelCustom = "channel_custom"
            case sponsored = "sponsored"
        }

        public struct Tier: Codable {
            let minBits: Int
            let id: String
            let canCheer: Bool
            let showInBitsCard: Bool
            let images: Images
            let color: String

            enum CodingKeys: String, CodingKey {
                case minBits = "min_bits"
                case id
                case canCheer = "can_cheer"
                case showInBitsCard = "show_in_bits_card"
                case images
                case color
            }

            public struct Images: Codable {
                let light: ImageData
                let dark: ImageData
    
                public struct ImageData: Codable {
                    let animatedSizes: Size
                    let staticSizes: Size

                    enum CodingKeys: String, CodingKey {
                        case animatedSizes = "animated"
                        case staticSizes = "static"
                    }

                    public struct Size: Codable {
                        let the1, the15, the2, the3, the4: String

                        enum CodingKeys: String, CodingKey {
                            case the1 = "1"
                            case the15 = "1.5"
                            case the2 = "2"
                            case the3 = "3"
                            case the4 = "4"
                        }
                    }
                }
            }
        }
    }
    
    func getBitsLeaderboard(count: Int? = nil, period: String? = nil, startedAt: String? = nil, userID: String? = nil, onCompletion: @escaping (Result<Paginated<BitsLeaderboardResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        if let count = count {
            parameters["count"] = String(count)
        }
        if let period = period {
            parameters["period"] = period
        }
        if let startedAt = startedAt {
            parameters["started_at"] = startedAt
        }
        if let userID = userID {
            parameters["user_id"] = userID
        }
        let endpoint = appendParameters(parameters, to: "bits/leaderboard")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
    
    func getBitsCheermotes(broadcasterID: String? = nil, onCompletion: @escaping (Result<Paginated<BitsCheermoteResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        if let broadcasterID = broadcasterID {
            parameters["broadcaster_id"] = broadcasterID
        }
        let endpoint = appendParameters(parameters, to: "bits/cheermotes")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
