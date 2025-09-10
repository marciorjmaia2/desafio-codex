import Foundation

struct NewsItem: Decodable, Identifiable, Hashable {
    let id: String
    let type: String?
    let content: NewsContent?
    let metadata: String?
    
    var title: String {
        content?.title ?? ""
    }
    
    var summary: String? {
        content?.summary
    }
    
    var url: URL? {
        if let u = content?.url {
            return URL(string: u)
        }
        return nil
    }
    
    var category: String? {
        content?.chapeu?.label ?? content?.section
    }
    
    var imageURL: URL? {
        if let u = content?.image?.bestURL {
            return URL(string: u)
        }
        return nil
    }
}

struct NewsContent: Decodable, Hashable {
    let chapeu: ContentLabel?
    let section: String?
    let image: ImageData?
    let summary: String?
    let title: String?
    let url: String?
}

struct ContentLabel: Decodable, Hashable {
    let label: String?
}
