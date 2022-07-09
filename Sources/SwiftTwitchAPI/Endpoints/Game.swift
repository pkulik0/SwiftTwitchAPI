//
//  Game.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

extension SwiftTwitchAPI {
    struct GameResponse: Codable {
        let id: String
        let name: String
        let boxArtUrl: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case boxArtUrl = "box_art_url"
        }
    }
    
    func getTopGames(onCompletion: @escaping (Result<Paginated<GameResponse>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "games/top", onCompletion: onCompletion)
    }
}
