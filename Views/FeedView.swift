import SwiftUI

struct FeedView: View {
    @StateObject private var vm = FeedViewModel()
    
    var body: some View {
        NavigationView {
            List(vm.items.indices, id: \.self) { index in
                let item = vm.items[index]
                let content = item["content"] as? [String: Any]
                let title = content?["title"] as? String ?? ""
                let imageDict = content?["image"] as? [String: Any]
                let sizes = imageDict?["sizes"] as? [String: Any]
                let sizeL = sizes?["L"] as? [String: Any]
                let imageUrl = (sizeL?["url"] as? String) ?? (imageDict?["url"] as? String) ?? ""
                let metadata = item["metadata"] as? String ?? ""
                let chapeu = (content?["chapeu"] as? [String: Any])?["label"] as? String ?? ""
                let section = content?["section"] as? String ?? ""
                _ = !chapeu.isEmpty ? chapeu : section
                
                let metaParts = Array(Set([metadata, chapeu.isEmpty ? section : chapeu]
                    .filter { !$0.isEmpty }))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color(red: 196/255, green: 23/255, blue: 12/255)) // #C4170C
                        .bold()
                    
                    if let url = URL(string: imageUrl) {
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
                            default:
                                Color.gray
                                    .frame(height: 200)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    
                    if !metaParts.isEmpty {
                        Text(metaParts.joined(separator: " • "))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
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
        }
        .task {
            await vm.loadFeed()
        }
    }
}
