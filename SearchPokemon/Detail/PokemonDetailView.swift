//
//  PokemonDetailView.swift
//  SearchPokemon
//
//  Created by jihye kim on 02/07/2024.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon: Pokemon

    var body: some View {
        ScrollView {
            VStack {
                PokemonImageCarouselView(imageUrls: pokemon.sprites.all)
                
                PokemonInfoView(pokemon: pokemon)
                    .padding(.horizontal)
                    .padding(.top, 16)
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(Constants.baseStatsTitle)
                        .font(.headline)
                        .padding(.vertical, 5)
                    PokemonStatView(pokemon: pokemon)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 32)
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}

extension PokemonDetailView {
    private enum Constants {
        static let baseStatsTitle = "BaseStats"
    }
}
