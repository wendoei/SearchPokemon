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
                PokemonImageCarouselView(imageDetails: pokemon.sprites.all)
                    .accessibilityElement(children: .contain)
                    .accessibilityLabel("Carousel of \(pokemon.name)'s images")
                
                PokemonInfoView(pokemon: pokemon)
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .accessibilityElement(children: .combine)
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(Constants.baseStatsTitle)
                        .font(.headline)
                        .padding(.vertical, 5)
                        .accessibilityLabel("Base Stats for \(pokemon.name)")
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
