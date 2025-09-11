//import SwiftUI
//
//struct NewsRowView: View {
//    let item: NewsItem
//
//    var body: some View {
//        HStack(alignment: .top, spacing: 12) {
//            if let urlString = item.content?.image?.sizes?.L.url,
//            let url = URL(string: urlString) {
//                AsyncImage(url: url) { phase in
//                    switch phase {
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 100, height: 80)
//                            .clipped()
//                            .cornerRadius(8)
//                    default:
//                        Color.gray.frame(width: 100, height: 80).cornerRadius(8)
//                    }
//                }
//            }
//            VStack(alignment: .leading, spacing: 6) {
//                Text(item.title)
//                    .font(.headline)
//                    .foregroundColor(Color(red: 196/255, green: 23/255, blue: 12/255)) 
//                    .bold()
//                if let summary = item.summary {
//                    Text(summary)
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                        .lineLimit(2)
//                }
//            }
//        }
//        .padding(.vertical, 4)
//    }
//}
