import SwiftUI

struct FeedView: View {
    @StateObject var vm: FeedViewModel //conecta feedViewModel
    @State private var selectedURL: URL? //guarda url
    
    var body: some View {
        NavigationStack { //permite navegar novas telas
            List {
                ForEach(vm.feedItems.indices, id: \.self) { index in //percorre a lista
                    let newsItem = vm.feedItems[index]
                    
                    if let urlString = newsItem.url, //pega urlString e tenta converter, se for valido cria o botao
                       let url = URL(string: urlString) {
                        Button {
                            selectedURL = url //armazena URL e dispara WebView
                        } label: {
                            NewsRowView(newsItem: newsItem) //Exibe o conteúdo da notícia com NewsRowView
                        }
                        .buttonStyle(.plain)
                    }
                    
                    if index == vm.feedItems.count - 1 { //quando chega o ultimo item da lista
                        ProgressView() //mostra o carregando
                            .task(id: vm.feedItems.count) {
                                await vm.loadMore()
                            }
                            }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable {
                await vm.loadFeed()
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
            .task { //ciclo de vida da View
                await vm.loadFeed()
            }
            .navigationDestination(item: $selectedURL) { url in
                WebView(url: url)
                    .navigationTitle("Notícia")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

