//
//  Commercials.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

public extension SwiftTwitchAPI {
    struct Commercial: Codable {
        public let message: String
        public let length: Int
        public let retryAfter: Int
        
        enum CodingKeys: String, CodingKey {
            case message
            case length
            case retryAfter = "retry_after"
        }
    }
    func runCommercial(broadcasterID: String, length: Int, onCompletion: @escaping (Result<Paginated<Commercial>, APIError>) -> Void) {
        requestAPI(endpoint: "channels/commercial", requestMethod: .POST, requestBody: ["broadcaster_id": broadcasterID, "length": length], onCompletion: onCompletion)
    }
}
