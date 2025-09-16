import SwiftUI

struct MenuView: View {
    @StateObject private var vm = MenuViewModel()
    
    var body: some View {
        NavigationStack {
            List(vm.menuItems) { item in
                if let url = URL(string: item.url) {
                    NavigationLink {
                        WebView(url: url)
                            .navigationTitle(item.title.capitalized)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text(item.title.capitalized)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Menu")
            .task {
                vm.loadMenu()
            }
        }
    }
}
