//
//  Tags.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

extension SwiftTwitchAPI {
    struct TagResponse: Codable {
        let tagID: String
        let isAuto: Bool
        let localizationNames: [String: String]
        let localizationDescriptions: [String: String]

        enum CodingKeys: String, CodingKey {
            case tagID = "tag_id"
            case isAuto = "is_auto"
            case localizationNames = "localization_names"
            case localizationDescriptions = "localization_descriptions"
        }
    }
    
    func getAllTags(tagIDs: [String]? = nil, after: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<TagResponse>, TwitchAPIError>) -> Void) {
        var parameters: [String: String] = [:]
        
        var endpoint = "tags/streams?"
        if let after = after {
            parameters["after"] = after
        }
        if let first = first {
            parameters["first"] = String(first)
        }
        if let tagIDs = tagIDs {
            tagIDs.forEach({ endpoint.append("tag_id=\($0)&") })
        }
        endpoint = appendParameters(parameters, to: endpoint)
        
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
