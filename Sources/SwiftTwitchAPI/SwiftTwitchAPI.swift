import Foundation

public struct SwiftTwitchAPI {
    let clientID: String
    let authToken: String

    public init(clientID: String, authToken: String) {
        self.clientID = clientID
        self.authToken = authToken
    }

    internal enum RequestMethod: String {
        case GET, POST, PUT, PATCH, DELETE
    }
    
    internal func appendParameters(_ parameters: [String: String], to endpoint: String) -> String {
        let parametersString = parameters.map { (key, value) in
            "\(key)=\(value)"
        }.joined(separator: "&")
        
        if !parametersString.isEmpty {
            return "\(endpoint)\(endpoint.contains("?") ? "&" : "?")\(parametersString)"
        }
        return endpoint
    }
    
    private func getRequest(url: URL, method: RequestMethod, body: [String: Any]) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(clientID, forHTTPHeaderField: "Client-Id")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = method.rawValue
        
        if method != .GET {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = try? JSONSerialization.data(withJSONObject: method)
        }
        
        return request
    }
    
    internal func requestTwitchAPI(endpoint: String, requestMethod: RequestMethod = .GET, requestBody: [String: Any] = [:],  onCompletion: @escaping (Result<Int, TwitchAPIError>) -> Void) {
        let apiURL = URL(string: "https://api.twitch.tv/helix/\(endpoint)")!
        let request = getRequest(url: apiURL, method: requestMethod, body: requestBody)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                onCompletion(.failure(.invalidResponse))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode

                if statusCode == 204 {
                    onCompletion(.success(statusCode))
                } else if statusCode == 401 {
                    onCompletion(.failure(.unauthorized))
                } else {
                    onCompletion(.failure(.invalidRequest))
                }
                return
            }
            
            onCompletion(.failure(.invalidResponse))
        }.resume()
    }
    
    internal func requestTwitchAPI<T: Codable>(endpoint: String, requestMethod: RequestMethod = .GET, requestBody: [String: Any] = [:],  onCompletion: @escaping (Result<T, TwitchAPIError>) -> Void) {
        let apiURL = URL(string: "https://api.twitch.tv/helix/\(endpoint)")!
        let request = getRequest(url: apiURL, method: requestMethod, body: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                onCompletion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                onCompletion(.failure(.invalidResponse))
                return
            }
            
            if let response = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                onCompletion(.failure(.serverError(error: response)))
                return
            }
            
            if let response = try? JSONDecoder().decode(T.self, from: data) {
                onCompletion(.success(response))
                return
            }

            onCompletion(.failure(.unknownData))
        }.resume()
    }
}
