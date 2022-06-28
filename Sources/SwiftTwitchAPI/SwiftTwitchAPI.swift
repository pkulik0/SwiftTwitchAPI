import Foundation

public struct SwiftTwitchAPI {
    private let clientID: String
    public var authToken: String?

    public init(clientID: String) {
        self.clientID = clientID
    }

    func requestAPI<T: Codable>(authToken: String, endpoint: String, completionHandler: @escaping (Result<T, TwitchAPIError>) -> Void) {
        let apiURL = URL(string: "https://api.twitch.tv/helix/\(endpoint)")!
        var request = URLRequest(url: apiURL)
        request.setValue(clientID, forHTTPHeaderField: "Client-Id")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data else {
                completionHandler(.failure(.serverError))
                return
            }

            if let response = try? JSONDecoder().decode(T.self, from: data) {
                completionHandler(.success(response))
                return
            }
            
            if let response = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                if response.status == 401 {
                    completionHandler(.failure(.invalidToken))
                    return
                }
            }
            completionHandler(.failure(.invalidData))
        }.resume()
    }
}
