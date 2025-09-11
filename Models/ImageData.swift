struct ImageData: Decodable, Hashable {
    let url: String?
    let sizes: [String: ImageSize]?
    
    struct ImageSize: Decodable, Hashable {
        let url: String?
        let width: Int?
        let height: Int?
    }
}
