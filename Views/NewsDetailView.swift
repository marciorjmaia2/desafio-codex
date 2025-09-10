import SwiftUI

struct NewsDetailView: View {
    let item: NewsItem

    var body: some View {
        VStack {
            if let url = item.url {
                Link("Abrir notícia completa", destination: url)
                    .font(.title2)
                    .padding()
            } else {
                Text("Sem link disponível")
            }
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
