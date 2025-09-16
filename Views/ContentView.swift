import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FeedView(vm: FeedViewModel(feedURL: "https://native-leon.globo.com/feed/g1"))
                .tabItem {
                    Label("G1", systemImage: "newspaper")
                }
            
            FeedView(vm: FeedViewModel(feedURL: "https://native-leon.globo.com/feed/https://g1.globo.com/economia/agronegocios"))
                .tabItem {
                    Label("Agro", systemImage: "tree")
                }
            
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "line.3.horizontal")
                }
        }
    }
}

