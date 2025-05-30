import Foundation
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let service: APIServiceProtocol
    private var nextPage: String?

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        fetchCharacters()
    }
    
    func fetchCharacters(from url: String? = nil) {
        isLoading = true
        errorMessage = nil

        service.fetchCharacters(from: url)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.characters.append(contentsOf: response.results)
                self.nextPage = response.info.next
            }
            .store(in: &cancellables)
    }

    func loadPage(current character: Character) {
        guard let last = characters.last else { return }
        if character.id == last.id, let next = nextPage {
            fetchCharacters(from: next)
        }
    }

}
