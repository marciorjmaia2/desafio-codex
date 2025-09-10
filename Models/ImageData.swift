struct ImageData: Decodable, Hashable {
    let url: String?
    let sizes: [String: ImageSize]?
    
    var bestURL: String? {
        // pega primeiro o tamanho "L", se não tiver tenta o "M"
        if let l = sizes?["L"]?.url {
            return l
        }
        if let m = sizes?["M"]?.url {
            return m
        }
        return url // fallback para o campo raiz
    }
}

struct ImageSize: Decodable, Hashable {
    let url: String?
    let width: Int?
    let height: Int?
}
