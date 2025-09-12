import SwiftUI

struct NewsRowView: View {
    let newsItem: NewsItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(newsItem.title)
                .font(.headline)
                .foregroundColor(Color(red: 196/255, green: 23/255, blue: 12/255))
                .bold()
            
            if let urlString = newsItem.content?.image?.sizes?.L.url,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(8)
                    case .failure(_):
                        Color.gray
                            .frame(height: 200)
                            .cornerRadius(8)
                    case .empty:
                        ProgressView()
                            .frame(height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            
            HStack {
                if let metadata = newsItem.metadata {
                    Text(metadata)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if let category = newsItem.category {
                    Text(category)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(.leading, 4)
                        .padding(.bottom, 4)
                }
            }
        }
        .padding(.horizontal)
    }
}

