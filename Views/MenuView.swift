import SwiftUI

struct MenuView: View {
    @StateObject private var vm = MenuViewModel()
    
    var body: some View {
        NavigationStack {
            List(vm.menuItems) { item in
                if let url = URL(string: item.url) { //verifica URL valida
                    NavigationLink {
                        WebView(url: url) //abre uma WebView
                            .navigationTitle(item.title.capitalized) //titulo primeira letra maiuscula
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
