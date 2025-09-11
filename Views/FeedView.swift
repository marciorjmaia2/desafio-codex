import SwiftUI

struct FeedView: View {
    @StateObject private var vm = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(vm.feedItems) { newsItem in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(newsItem.title)
                                .font(.headline)
                                .foregroundColor(Color(red: 196/255, green: 23/255, blue: 12/255))
                                .bold()
                            
                            if let urlString = newsItem.imageURL,
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
                        }
                        .padding(.horizontal)
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
        }
    }
}

