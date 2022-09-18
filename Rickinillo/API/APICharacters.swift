//
//  APICharacters.swift
//  Rickinillo
//
//  Created by Miguel Jardón on 18/9/22.
//

import SwiftUI

typealias CharacterListResponse = (Characters?) -> Void
typealias RequestResponse = (Data?) -> Void

/// Options to be used in App load to filter (future implementation or just an slice of all character list)
enum APICharacterEndpoint {
    case char(Int)
    case allChars
    case charFilter(String)
    case charList(Int)
    
    enum APICharFilter {
        case name, status, species, gender
    }
    
    func urlString() -> String {
        switch self {
        case .char(let charID):
            return "https://rickandmortyapi.com/api/character/\(charID)"
        case .allChars:
            return "https://rickandmortyapi.com/api/character"
        case .charFilter(let filter):
            return "https://rickandmortyapi.com/api/character/?\(filter)"
        case .charList(let count):
            var idsArray = [Int]()
            for i in 1...count {
                idsArray.append(i)
            }
            let ids = idsArray.map { String($0) }.joined(separator: ",")
            return "https://rickandmortyapi.com/api/character/\(ids)"
        }
    }
}


// MARK: - Public methods

/// Generic method to retrieve a specific character list
/// - Parameters:
///   - endpoint: a supported endpoint
///   - completion: block where if be returned the model parsed
func GETChar(_ endpoint: APICharacterEndpoint, completion: @escaping CharacterListResponse) {
    switch endpoint {
    case .char(_):
        getCharacter(endpoint.urlString(), completion: completion)
    case .allChars:
        getAllCharacters(endpoint.urlString(), completion: completion)
    case .charFilter(_):
        getFilteredChars(endpoint.urlString(), completion: completion)
    case .charList(_):
        getCharacterList(endpoint.urlString(), completion: completion)
    }
}

func getNextPrevCharPage(_ url: String, completion: @escaping CharacterListResponse) {
    getAllCharacters(url, completion: completion)
}

func getCharacter(_ url: String, completion: @escaping CharacterListResponse) {
    performRequest(url) { characterData in
        parseCharacterJSON(characterData) { character in
            DispatchQueue.main.async {
                completion(character)
            }
        }
    }
}

func getAllCharacters(_ url: String, completion: @escaping CharacterListResponse) {
    performRequest(url) { charactersData in
        parseAllCharactersJSON(charactersData) { characters in
            DispatchQueue.main.async {
                completion(characters)
            }
        }
    }
}

func getCharacterList(_ url: String, completion: @escaping CharacterListResponse) {
    performRequest(url) { charactersData in
        parseCharactersJSON(charactersData) { characters in
            DispatchQueue.main.async {
                completion(characters)
            }
        }
    }
}

func getFilteredChars(_ url: String, completion: @escaping CharacterListResponse) {
    getAllCharacters(url, completion: completion)
}


// MARK: - Aux methods

func parseCharactersJSON(_ data: Data?, completion: CharacterListResponse) {
    guard let data = data else {
        completion(nil)
        return
    }
    
    let chars = try? JSONDecoder().decode([Character].self, from: data)
    
    let info = Characters.Info(count: chars?.count ?? 0)
    let characters = Characters(info: info,
                                results: chars ?? [])
    completion(characters)
}

private func parseAllCharactersJSON(_ data: Data?, completion: CharacterListResponse) {
    guard let data = data else {
        completion(nil)
        return
    }

    let characters = try? JSONDecoder().decode(Characters.self, from: data)
    completion(characters)
}

private func parseCharacterJSON(_ data: Data?, completion: CharacterListResponse) {
    guard let data = data else {
        completion(nil)
        return
    }
    
    let character = try? JSONDecoder().decode(Character.self, from: data)
    var charsArray = [Character]()
    
    if let character = character  {
        charsArray.append(character)
    }
    
    let info = Characters.Info(count: charsArray.count)
    let characters = Characters(info: info,
                                results: charsArray)
    
    completion(characters)
}
