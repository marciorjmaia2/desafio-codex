import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var feedItems: [NewsItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadFeed() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let response = try await NewsAPI.fetchData()
            feedItems = response.feed?.falkor?.items ?? []
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

