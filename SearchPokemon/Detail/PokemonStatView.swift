//
//  PokemonStatView.swift
//  SearchPokemon
//
//  Created by jihye kim on 04/07/2024.
//

import SwiftUI

struct PokemonStatView: View {
    @Environment(\.dynamicTypeSize)
    private var dynamicTypeSize: DynamicTypeSize
    
    var dynamicLayout: AnyLayout {
        dynamicTypeSize.isAccessibilitySize ?
        AnyLayout(VStackLayout(alignment: .leading)) : AnyLayout(HStackLayout())
    }
    
    var sortedStats: [Pokemon.StatInfo]
    
    @State private var maxStatLabelWidth: CGFloat = 0
    @State private var progress: Double = 0
    
    private var maxStatValue: Double {
        let maxValue = sortedStats.map { Double($0.baseStat) }.max() ?? 100
        return maxValue * 4 / 3
    }

    var body: some View {
        VStack {
            ForEach(self.sortedStats, id: \.stat.name) { statInfo in
                dynamicLayout {
                    Text(statInfo.stat.name.capitalized)
                        .font(.subheadline)
                        .frame(width: maxStatLabelWidth, alignment: .leading)
                        
                    Spacer()

                    AnimatingProgressView(
                        value: Double(statInfo.baseStat),
                        total: maxStatValue,
                        color: progressBarColor(forStat: statInfo.stat.name)
                    )
                }
                .padding(.vertical, 4)
                .accessibilityElement(children: .combine)
            }
        }
        .onAppear {
            self.maxStatLabelWidth = calculateStatLabelWidth(for: self.sortedStats.last)
        }
        .onChange(of: dynamicTypeSize) {
            self.maxStatLabelWidth = calculateStatLabelWidth(for: self.sortedStats.last)
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
    
    func calculateStatLabelWidth(for statInfo: Pokemon.StatInfo?) -> CGFloat {
        guard let statInfo else { return .zero }
        // TODO: not using UIFont
        let font = UIFont.preferredFont(forTextStyle: .subheadline)
        return statInfo.stat.name.capitalized.width(usingFont: font)
    }
}
