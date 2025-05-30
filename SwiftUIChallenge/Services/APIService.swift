import Foundation
import Combine

protocol APIServiceProtocol {
    func fetchCharacters(from urlString: String?) -> AnyPublisher<CharacterResponse, Error>
}

class APIService: APIServiceProtocol {
    private let baseURL = "https://rickandmortyapi.com/api/character"

    func fetchCharacters(from urlString: String? = nil) -> AnyPublisher<CharacterResponse, Error> {
        guard let url = URL(string: urlString ?? baseURL) else {
            return Fail(error: APIServiceError.invalidURL)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CharacterResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
