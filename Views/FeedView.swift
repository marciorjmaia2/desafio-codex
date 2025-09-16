import SwiftUI

struct FeedView: View {
    @StateObject var vm: FeedViewModel
    @State private var selectedURL: URL?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.feedItems.indices, id: \.self) { index in
                    let newsItem = vm.feedItems[index]
                    
                    if let urlString = newsItem.url,
                       let url = URL(string: urlString) {
                        Button {
                            selectedURL = url
                        } label: {
                            NewsRowView(newsItem: newsItem)
                        }
                        .buttonStyle(.plain)
                    }
                    
                    if index == vm.feedItems.count - 1 {
                        ProgressView()
                            .onAppear {
                                Task {
                                    await vm.loadMore()
                                }
                            }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable {
                await vm.loadFeed()
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
            .navigationDestination(item: $selectedURL) { url in
                WebView(url: url)
                    .navigationTitle("Notícia")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

