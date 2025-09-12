import SwiftUI

struct FeedView: View {
    @StateObject private var vm = FeedViewModel()
    @State private var selectedURL: URL?
    @State private var isShowingWebView = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(vm.feedItems) { newsItem in
                        Button {
                            if let urlString = newsItem.url,
                               let url = URL(string: urlString) {
                                selectedURL = url
                                isShowingWebView = true
                            }
                        } label: {
                            NewsRowView(newsItem: newsItem)
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("Logotipo_g1")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 36)
                        .padding(.leading, 8)
                }
            }
            .task {
                await vm.loadFeed()
            }
            .sheet(isPresented: $isShowingWebView) {
                if let url = selectedURL {
                    WebView(url: url)
                }
            }
        }
    }
}
