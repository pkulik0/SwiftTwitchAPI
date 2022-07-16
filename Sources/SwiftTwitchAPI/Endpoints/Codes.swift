//
//  Codes.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

extension SwiftTwitchAPI {
    struct CodeResponse: Codable {
        let code: String
        let status: CodeStatus
    }
    
    enum CodeStatus: String, Codable {
        case successfullyRedemeed = "SUCCESSFULLY_REDEEMED"
        case alreadyClaimed = "ALREADY_CLAIMED"
        case expired = "EXPIRED"
        case userNotEligible = "USER_NOT_ELIGIBLE"
        case notFound = "NOT_FOUND"
        case inactive = "INACTIVE"
        case unused = "UNUSED"
        case incorrectFormat = "INCORRECT_FORMAT"
        case internalError = "INTERNAL_ERROR"
    }
    
    func getCodeStatus(userID: String, codes: [String], onCompletion: @escaping (Result<Paginated<CodeResponse>, TwitchAPIError>) -> Void) {
        if codes.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }

        var endpoint = "entitlements/codes?user_id=\(userID)"
        codes.forEach({ endpoint.append("&code=\($0)") })
        
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
