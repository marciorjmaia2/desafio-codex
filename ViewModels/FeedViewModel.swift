import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var feedItems: [NewsItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let baseURL: String
    private var nextPage: Int? = 1
    private var currentOfferID: String?

    init(feedURL: String) {
        self.baseURL = feedURL
    }

    func loadFeed() async {
        nextPage = 1
        feedItems.removeAll()
        currentOfferID = nil
        await loadMore()
    }

    func loadMore() async {
        guard let page = nextPage, !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        var urlString: String

        if page == 1 {
            urlString = baseURL
        } else if let oferta = currentOfferID {
            urlString = "https://native-leon.globo.com/feed/page/g1/\(oferta)/\(page)"
        } else {
            return
        }

        do {
            let response = try await NewsAPI.fetchData(from: urlString)
            if page == 1 {
                currentOfferID = response.feed?.oferta
            }

            let newItems = (response.feed?.falkor?.items ?? [])
                .filter { $0.type == "basico" || $0.type == "materia" }

            feedItems.append(contentsOf: newItems)
            nextPage = response.feed?.falkor?.nextPage
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

