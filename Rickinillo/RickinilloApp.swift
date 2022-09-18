//
//  RickinilloApp.swift
//  Rickinillo
//
//  Created by Miguel Jardón on 18/9/22.
//

import SwiftUI

@main
struct RickinilloApp: App {
    @State var characters: Characters!
    @State var loaded = false
    
//#if TESTING
    let isRunningTests = NSClassFromString("XCTestCase") != nil
//#endif
    
    var body: some Scene {
        WindowGroup {
            if loaded {
                CharacterListView()
            } else {
                if isRunningTests {
                    Text("Testing...")
                } else {
                    InitialLoadingView()
                        .onAppear() {                            
                            GETChar(.allChars) { characters in
                                if let characters = characters {
                                    self.characters = characters
                                    loaded = true
                                } else {
                                    print("¡¡¡¡error!!!!!")
                                }
                            }
                        }
                }
            }
        }
    }
}
