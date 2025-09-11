import Foundation

class NewsAPI {
    static func fetchData() async throws -> NewsResponse {
        guard let url = URL(string: "https://native-leon.globo.com/feed/g1") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(NewsResponse.self, from: data)
    }
}
