import Foundation

struct Character: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String?
    var image: String
}

