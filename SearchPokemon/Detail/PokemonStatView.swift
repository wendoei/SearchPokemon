//
//  PokemonStatView.swift
//  SearchPokemon
//
//  Created by jihye kim on 04/07/2024.
//

import SwiftUI

struct PokemonStatView: View {
    var pokemon: Pokemon
    
    @State private var progress: Double = 0
    
    private var maxStatValue: Double {
        let maxValue = pokemon.stats.map { Double($0.baseStat) }.max() ?? 100
        return maxValue * 4 / 3
    }

    var body: some View {
        VStack {
            ForEach(pokemon.stats.sorted(), id: \.stat.name) { statInfo in
                HStack {
                    Text(statInfo.stat.name.capitalized)
                        .font(.subheadline)
                        .frame(width: 120, alignment: .leading)
                        
                    Spacer()

                    AnimatingProgressView(
                        value: Double(statInfo.baseStat),
                        total: maxStatValue,
                        color: progressBarColor(forStat: statInfo.stat.name)
                    )
                }
                .padding(.vertical, 4)
            }
        }
    }
    
    func progressBarColor(forStat statName: String) -> Color {
        switch statName {
        case "hp": return .red
        case "attack": return .orange
        case "defense": return .yellow
        case "special-attack": return .green
        case "special-defense": return .blue
        case "speed": return .purple
        default: return .gray
        }
    }
}
