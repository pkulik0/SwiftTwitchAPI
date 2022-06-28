//
//  Game.swift
//  
//
//  Created by pkulik0 on 28/06/2022.
//

extension SwiftTwitchAPI {
    class GameResponse: Codable {
        let id: String
        let name: String
        let box_art_url: String
    }
    
    func getTopGames(completionHandler: @escaping (Result<Paginated<[GameResponse]>, TwitchAPIError>) -> Void) {
        guard let authToken = authToken else {
            completionHandler(.failure(.missingToken))
            return
        }

        requestAPI(authToken: authToken, endpoint: "games/top", completionHandler: completionHandler)
    }
}
