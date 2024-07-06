//
//  PokemonInfoView.swift
//  SearchPokemon
//
//  Created by jihye kim on 04/07/2024.
//

import SwiftUI

struct PokemonInfoView: View {
    var pokemon: Pokemon

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(String(format: Constants.Formats.id, pokemon.id))
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("Pokémon ID \(pokemon.id)")
                
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityLabel("Pokémon name \(pokemon.name)")
            }
            
            Spacer()
            
            HStack {
                ForEach(pokemon.types, id: \.type.name) { typeInfo in
                    TypeCapsuleView(typeName: typeInfo.type.name)
                        .accessibilityLabel("Pokémon type \(typeInfo.type.name)")
                }
            }
        }
    }
}

extension PokemonInfoView {
    private enum Constants {
        enum Formats {
            static let id = "#%04d"
        }
    }
}
