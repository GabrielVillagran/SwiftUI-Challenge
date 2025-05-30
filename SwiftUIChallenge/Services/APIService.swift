import Foundation
import Combine

class APIService {
    private let baseURL = "https://rickandmortyapi.com/api/character"

    func fetchCharacters(from urlString: String? = nil) -> AnyPublisher<CharacterResponse, Error> {
        let urlToUse = URL(string: urlString ?? baseURL)!
        
        return URLSession.shared.dataTaskPublisher(for: urlToUse)
            .map(\.data)
            .decode(type: CharacterResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
