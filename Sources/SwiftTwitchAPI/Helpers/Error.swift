//
//  Error.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

public extension SwiftTwitchAPI {
    class ErrorResponse: Codable {
        public let error: String
        public let message: String
        public let status: Int
    }

    enum TwitchAPIError: Error {
        case missingToken, invalidResponse, invalidRequest, unknownData, serverError(error: ErrorResponse), tooFewParameters, unauthorized
    }
}
