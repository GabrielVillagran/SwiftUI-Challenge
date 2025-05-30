import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}
