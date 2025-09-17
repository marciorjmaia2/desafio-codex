import Foundation

@MainActor
class MenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = []
    @Published var errorMessage: String?

    func loadMenu() {
        guard let url = Bundle.main.url(forResource: "menu", withExtension: "json") else { //procura arquivo menun dentro do projeto
            errorMessage = "menu.json não encontrado no projeto"
            return
        }

        do {
            let data = try Data(contentsOf: url) //lê o conteudo
            let response = try JSONDecoder().decode(MenuResponse.self, from: data) //transforma JSON em objeto
            self.menuItems = response.menuItems //pega a lista de menuItems e coloca em self.menuItems
        } catch {
            errorMessage = "Erro ao carregar menu: \(error.localizedDescription)"
        }
    }
}
