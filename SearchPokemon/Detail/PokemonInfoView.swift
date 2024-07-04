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
                
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            HStack {
                ForEach(pokemon.types, id: \.type.name) { typeInfo in
                    TypeCapsuleView(typeName: typeInfo.type.name)
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
