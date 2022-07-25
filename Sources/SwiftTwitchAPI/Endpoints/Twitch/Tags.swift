//
//  Tags.swift
//  
//
//  Created by pkulik0 on 16/07/2022.
//

extension SwiftTwitchAPI {
    public struct Tag: Codable {
        public let tagID: String
        public let isAuto: Bool
        public let localizationNames: [String: String]
        public let localizationDescriptions: [String: String]

        enum CodingKeys: String, CodingKey {
            case tagID = "tag_id"
            case isAuto = "is_auto"
            case localizationNames = "localization_names"
            case localizationDescriptions = "localization_descriptions"
        }
    }
    
    public func getTags(tagIDs: [String]? = nil, after: String? = nil, first: Int? = nil, onCompletion: @escaping (Result<Paginated<Tag>, APIError>) -> Void) {
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
    
    public func getChannelTags(broadcasterID: String, onCompletion: @escaping (Result<Paginated<Tag>, APIError>) -> Void) {
        requestAPI(endpoint: "streams/tags?broadcaster_id=\(broadcasterID)", onCompletion: onCompletion)
    }
    
    public func updateChannelTags(broadcasterID: String, tagIDs: [String] = [], onCompletion: @escaping (Result<Int, APIError>) -> Void) {
        var requestBody: [String: Any] = [:]
        requestBody["tag_ids"] = tagIDs
        
        requestAPI(endpoint: "streams/tags?broadcaster_id=\(broadcasterID)", requestMethod: .PUT, requestBody: requestBody, onCompletion: onCompletion)
    }
}
