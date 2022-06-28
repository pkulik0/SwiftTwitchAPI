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
        let box_art_url: String
    }
    
    func getTopGames(completionHandler: @escaping (Result<Paginated<[GameResponse]>, TwitchAPIError>) -> Void) {
        requestAPI(endpoint: "games/top", completionHandler: completionHandler)
    }
}
