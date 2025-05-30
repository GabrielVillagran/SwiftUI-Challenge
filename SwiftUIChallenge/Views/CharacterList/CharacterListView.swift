import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailsView(character: character)) {
                    HStack {
                        Text(character.name)
                            .font(.body)
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: character.image)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        
                    }
                    .onAppear {
                        viewModel.loadPage(current: character)
                    }
                    
                }
            }
            .navigationTitle("Character List")
            .overlay(
                Group {
                    if viewModel.isLoading && viewModel.characters.isEmpty {
                        ProgressView("Loading")
                    }
                }
            )
        }
    }
}


#Preview {
    CharacterListView()
}
