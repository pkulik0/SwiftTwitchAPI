//
//  Extensions.swift
//  
//
//  Created by pkulik0 on 29/06/2022.
//

extension SwiftTwitchAPI {
    struct ExtensionTransactionResponse: Codable {
        let id: String
        let timestamp: String
        let broadcasterID: String
        let broadcasterLogin: String
        let broadcasterName: String
        let userID: String
        let userLogin: String
        let userName: String
        let expiration: String
        let broadcast: Bool
        let productType: String
        let productData: Product
        
        enum CodingKeys: String, CodingKey {
            case id
            case timestamp
            case broadcasterID = "broadcaster_id"
            case broadcasterLogin = "broadcaster_login"
            case broadcasterName = "broadcaster_name"
            case userID = "user_id"
            case userLogin = "user_login"
            case userName = "user_name"
            case expiration
            case broadcast
            case productType = "product_type"
            case productData = "product_data"
        }
        
        struct Product: Codable {
            let domain: String
            let sku: String
            let cost: Cost
            let inDevelopment: Bool
            let displayName: String
            
            struct Cost: Codable {
                let amount: Int
                let type: String
            }
        }
    }
    
    func getExtensionTransactions(ids: [String], after: String? = nil, first: Int? = nil, extensionID: String, onCompletion: @escaping (Result<Paginated<[ExtensionTransactionResponse]>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        
        if let after = after {
            parameters["after"] = after
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        
        var endpoint = appendParameters(parameters, to: "extensions/transactions")
        ids.forEach({ endpoint = appendParameters(["id": $0], to: endpoint) })
        
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
