import Foundation

class NewsAPI {
    static func fetchRawFeed() async throws -> Any {
        guard let url = URL(string: "https://native-leon.globo.com/feed/g1") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
}
