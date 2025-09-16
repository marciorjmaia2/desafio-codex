import Foundation

class NewsAPI {
    static func fetchData(from urlString: String) async throws -> NewsResponse {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(NewsResponse.self, from: data)
    }
}

