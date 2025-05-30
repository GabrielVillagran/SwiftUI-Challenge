import Foundation

struct Character: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let image: String
}

