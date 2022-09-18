//
//  CellDetailView.swift
//  Rickinillo
//
//  Created by Miguel Jardón on 18/9/22.
//

import SwiftUI

/// Detailed view of a character
struct CellDetailView: View {
    @State var character: Character
    @State var location: Location? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    HStack {
                        Text(character.name).bold().font(.largeTitle)
                    }
                    
                    AsyncImage(url: character.avatar) { charImage in
                        charImage
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        VStack(spacing: 10) {
                            Image("noImage", bundle: .main)
                                .resizable()
                                .scaledToFit()
                            ProgressView()
                            Text("Rickninillo in progress...")
                        }
                    }
                    
                    VStack {
                        Text("Character details")
                            .bold()
                            .font(.title2)
                            .frame(alignment: .leading)
                        
                        HStack {
                            Text("Gender:").bold()
                            Text(character.gender)
                        }
                        HStack {
                            Text("Specie:").bold()
                            Text(character.species)
                        }
                        HStack {
                            Text("Status:").bold()
                            Text(character.status)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Text("Location information")
                        .bold()
                        .font(.title2)
                        .frame(alignment: .leading)
                    
                    if let location = location {
                        HStack {
                            Text("\(location.type):").bold()
                            Text(location.name)
                        }
                        HStack {
                            Text("Dimension:").bold()
                            Text(location.dimension)
                        }
                    } else {
                        HStack {
                            Text("Loading location info... ")
                            ProgressView()
                        }
                    }
                }
                .padding()
                
                Spacer()
                
            }.onAppear {
                getLocation(character.location.url) { location in
                    self.location = location
                }
            }
        }
    }
}

struct CharDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let char = Character(id: 1,
                             name: "Rick Sanchez",
                             species: "human",
                             avatar: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                             status: "Alive",
                             gender: "Male")
        let location = Location(id: 1,
                                name: "Earth",
                                type: "Planet",
                                dimension: "long",
                                residents: [char.name])
        
        CellDetailView(character: char, location: location)
    }
}
