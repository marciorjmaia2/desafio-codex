import Foundation

struct MenuItem: Decodable, Identifiable {
    var id: UUID { UUID() }
    let title: String
    let url: String
}
