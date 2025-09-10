import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var items: [[String: Any]] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadFeed() async {
        isLoading = true
        defer { isLoading = false }
        do {
            if let json = try await NewsAPI.fetchRawFeed() as? [String: Any],
               let feed = json["feed"] as? [String: Any],
               let falkor = feed["falkor"] as? [String: Any],
               let rawItems = falkor["items"] as? [[String: Any]] {
                items = rawItems
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
