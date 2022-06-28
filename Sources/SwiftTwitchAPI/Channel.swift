//
//  Channel.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

extension SwiftTwitchAPI {
    class ChannelResponse: Codable {
        let broadcaster_id: String
        let broadcaster_login: String
        let broadcaster_name: String
        let broadcaster_language: String
        
        let game_name: String
        let game_id: String
        
        let title: String
        let delay: Int
    }
    
    func getChannel(broadcaster_ids: [String], completionHandler: @escaping (Result<Paginated<[ChannelResponse]>, TwitchAPIError>) -> Void) {
        guard let authToken = authToken else {
            completionHandler(.failure(.missingToken))
            return
        }
        var endpoint = "channels?"
        for id in broadcaster_ids {
            endpoint += "broadcaster_id=\(id)&"
        }
        requestAPI(authToken: authToken, endpoint: endpoint, completionHandler: completionHandler)
    }
}
