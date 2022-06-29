//
//  Bits.swift
//  
//
//  Created by pkulik0 on 29/06/2022.
//

extension SwiftTwitchAPI {
    struct BitsLeaderboardResponse: Codable {
        let user_id: String
        let user_login: String
        let user_name: String
        
        let rank: Int
        let score: Int
        let total: Int

        let dateRange: DateRange
    }
    
    struct BitsCheermoteResponse: Codable {
        let lastUpdated: String
        let order: Int
        let prefix: String
        let type: TypeEnum
        let isCharitable: Bool
        let tiers: [Tier]

        enum CodingKeys: String, CodingKey {
            case lastUpdated = "last_updated"
            case order
            case prefix
            case type
            case isCharitable = "is_charitable"
            case tiers
        }
        
        enum TypeEnum: String, Codable {
            case globalFirstParty = "global_first_party"
            case globalThirdParty = "global_third_party"
            case displayOnly = "display_only"
            case channelCustom = "channel_custom"
            case sponsored = "sponsored"
        }

        struct Tier: Codable {
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

            struct Images: Codable {
                let light: Image
                let dark: Image
    
                struct Image: Codable {
                    let animatedSizes: Size
                    let staticSizes: Size

                    enum CodingKeys: String, CodingKey {
                        case animatedSizes = "animated"
                        case staticSizes = "static"
                    }

                    struct Size: Codable {
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
    
    func getBitsLeaderboard(count: Int? = nil, period: String? = nil, started_at: String? = nil, user_id: String? = nil, onCompletion: @escaping (Result<Paginated<[BitsLeaderboardResponse]>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        if let count = count {
            parameters["count"] = String(count)
        }
        if let period = period {
            parameters["period"] = period
        }
        if let started_at = started_at {
            parameters["started_at"] = started_at
        }
        if let user_id = user_id {
            parameters["user_id"] = user_id
        }
        let endpoint = appendParameters(parameters, to: "bits/leaderboard")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
    
    func getBitsCheermotes(broadcaster_id: String? = nil, onCompletion: @escaping (Result<Paginated<[BitsCheermoteResponse]>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        if let broadcaster_id = broadcaster_id {
            parameters["broadcaster_id"] = broadcaster_id
        }
        let endpoint = appendParameters(parameters, to: "bits/cheermotes")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}