struct ImageData: Decodable, Hashable {
    let sizes: ImageSize?
}
 
struct ImageSize: Decodable, Hashable {
    var L: ImageProperties
}
 
struct ImageProperties: Decodable, Hashable {
    let url: String?
    let width: Int?
    let height: Int?
}
