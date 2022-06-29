//
//  Commercial.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

extension SwiftTwitchAPI {
    struct CommercialResponse: Codable {
        let message: String
        let length: Int
        let retryAfter: Int
        
        enum CodingKeys: String, CodingKey {
            case message
            case length
            case retryAfter = "retry_after"
        }
    }
    func runCommercial(broadcaster_id: String, length: Int, onCompletion: @escaping (Result<Paginated<[CommercialResponse]>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "channels/commercial", requestMethod: .POST, requestBody: ["broadcaster_id": broadcaster_id, "length": length], onCompletion: onCompletion)
    }
}
