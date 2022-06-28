//
//  TwitchAPIError.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

extension SwiftTwitchAPI {
    class ErrorResponse: Codable {
        let error: String
        let message: String
        let status: Int
    }

    enum TwitchAPIError: Error {
        case missingToken, invalidToken, serverError, invalidData
    }
}
