//
//  Games.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

extension SwiftTwitchAPI {
    struct CategoryResponse: Codable {
        let id: String
        let name: String
        let boxArtUrl: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case boxArtUrl = "box_art_url"
        }
    }
    
    func getTopCategories(after: String? = nil, before: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<CategoryResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        
        if let after = after {
            parameters["after"] = after
        }
        if let before = before {
            parameters["before"] = before
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        
        let endpoint = appendParameters(parameters, to: "games/top")
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
    
    func getCategories(gameIDs: [String] = [], names: [String] = [], onCompletion: @escaping (Result<Paginated<CategoryResponse>, TwitchAPIError>) -> Void) {
        if gameIDs.isEmpty && names.isEmpty {
            onCompletion(.failure(.tooFewParameters))
            return
        }
        
        var endpoint = "games?"
        gameIDs.forEach({ endpoint.append("id=\($0)&") })
        names.forEach({ endpoint.append("name=\($0)&") })
        
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
    
    func findCategories(query: String, after: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<CategoryResponse>, TwitchAPIError>) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let encodedQuery = encodedQuery else {
            onCompletion(.failure(.invalidRequest))
            return
        }

        var parameters: [String: String] = [:]
        
        if let after = after {
            parameters["after"] = after
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        
        requestAPI(endpoint: "search/categories?query=\(encodedQuery)", onCompletion: onCompletion)
    }
}
