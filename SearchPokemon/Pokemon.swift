//
//  Pokemon.swift
//  SearchPokemon
//
//  Created by jihye kim on 02/07/2024.
//

import Foundation

struct Pokemon: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let stats: [StatInfo]
    let sprites: Sprites
    let types: [TypeInfo]
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Pokemon {
    struct StatInfo: Decodable, Comparable {
        let baseStat: Int
        let stat: Stat
        
        static func == (lhs: Pokemon.StatInfo, rhs: Pokemon.StatInfo) -> Bool {
            lhs.stat.name == rhs.stat.name
        }
        
        static func < (lhs: StatInfo, rhs: StatInfo) -> Bool {
            return lhs.stat.name.count < rhs.stat.name.count
        }
        
        struct Stat: Decodable {
            let name: String
        }
    }
}

extension Pokemon {
    struct Sprites: Decodable {
        let frontDefault: URL?
        let frontFemale: URL?
        let backDefault: URL?
        let backFemale: URL?
        let frontShiny: URL?
        let frontShinyFemale: URL?
        let backShiny: URL?
        let backShinyFemale: URL?
        
        var all: [URL] {
            [
                frontDefault,
                backDefault,
                frontFemale,
                backFemale,
                frontShiny,
                backShiny,
                frontShinyFemale,
                backShinyFemale
            ]
            .compactMap { $0 }
        }
    }
}

extension Pokemon {
    struct TypeInfo: Decodable {
        let type: Detail
        
        struct Detail: Decodable {
            let name: String
        }
    }
}
