//
//  Channel.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

extension SwiftTwitchAPI {
    struct ChannelResponse: Codable {
        let broadcaster_id: String
        let broadcaster_login: String
        let broadcaster_name: String
        let broadcaster_language: String
        
        let game_name: String
        let game_id: String
        
        let title: String
        let delay: Int
    }
    
    func getChannel(broadcaster_ids: [String], onCompletion: @escaping (Result<Paginated<[ChannelResponse]>, TwitchAPIError>) -> Void) {
        var endpoint = "channels?"
        for id in broadcaster_ids {
            endpoint += "broadcaster_id=\(id)&"
        }
        requestAPI(endpoint: endpoint, onCompletion: onCompletion)
    }
}
