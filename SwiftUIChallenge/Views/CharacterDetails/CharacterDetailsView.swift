import SwiftUI

struct CharacterDetailsView: View {
    let character: Character
    
    var body: some View {
        VStack(spacing: 20) {
            Text(character.name)
                 .font(.largeTitle)
                 .bold()

             Text("Species: \(character.species)")
                 .font(.title2)

             Text("Status: \(character.status)")
                 .font(.title3)
            
            Text("Status: \(character.type)")
                .font(.title3)
            
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            
             Spacer()
        }
        .padding()
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
