//
//  CharacterListView.swift
//  Rickinillo
//
//  Created by Miguel Jardón on 18/9/22.
//

import SwiftUI

/// Principal view, a paged list of characters with detail view interaction
struct CharacterListView: View {
    @ObservedObject var page = PagedCharacters()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(page.list.results) { character in
                    NavigationLink(destination: CellDetailView(character: character)) {
                        CharacterCellView(character: character)
                    }
                }
                
                if page.membersListFull == false {
                    ProgressView()
                        .onAppear {
                            page.fetchMembers()
                        }
                }
            }
            .navigationTitle("Characters")
        }
    }
}

struct CharacterTabView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
