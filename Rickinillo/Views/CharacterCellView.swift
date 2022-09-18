//
//  CharacterCellView.swift
//  Rickinillo
//
//  Created by Miguel Jardón on 18/9/22.
//

import SwiftUI

/// CellView of a character for ChannelListView
struct CharacterCellView: View {
    let character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: character.avatar) { charImage in
                charImage
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(200)
                    .grayscale(1)
                    .contrast(2)
            } placeholder: {
                VStack(spacing: 10) {
                    Image("noImage", bundle: .main)
                        .resizable()
                        .scaledToFit()
                    ProgressView()
                    Text("Rickninillo in progress...")
                }
            }
            
            Text(character.name)
                .padding()
                .font(.headline)
                .foregroundColor(.black)
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        let char = Character(id: 1,
                  name: "Rick Sanchez",
                  species: "human",
                  avatar: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                  status: "Alive",
                  gender: "Male")
        CharacterCellView(character: char)
    }
}
