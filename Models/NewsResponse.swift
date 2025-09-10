import Foundation

struct NewsResponse: Decodable {
    let feed: Feed?
}

struct Feed: Decodable {
    let oferta: String?
    let falkor: Falkor?
}

struct Falkor: Decodable {
    let items: [NewsItem]?
}
