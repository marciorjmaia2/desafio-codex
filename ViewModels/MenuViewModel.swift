import Foundation

@MainActor
class MenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = []
    @Published var errorMessage: String?

    func loadMenu() {
        guard let url = Bundle.main.url(forResource: "menu", withExtension: "json") else {
            errorMessage = "menu.json não encontrado no projeto"
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(MenuResponse.self, from: data)
            self.menuItems = response.menuItems
        } catch {
            errorMessage = "Erro ao carregar menu: \(error.localizedDescription)"
        }
    }
}
