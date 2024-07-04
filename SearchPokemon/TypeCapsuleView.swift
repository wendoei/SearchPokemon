//
//  TypeCapsuleView.swift
//  SearchPokemon
//
//  Created by jihye kim on 04/07/2024.
//

import SwiftUI

struct TypeCapsuleView: View {
    var typeName: String
    
    var body: some View {
        Text(typeName.capitalized)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(self.backgroundColor(forType: typeName))
            .clipShape(Capsule())
    }
    
    func backgroundColor(forType typeName: String) -> Color {
        switch typeName.lowercased() {
        case "normal": return Color.gray
        case "fire": return Color.red
        case "water": return Color.blue
        case "electric": return Color.yellow
        case "grass": return Color.green
        case "ice": return Color.cyan
        case "fighting": return Color.orange
        case "poison": return Color.purple
        case "ground": return Color.brown
        case "flying": return Color(red: 0.68, green: 0.85, blue: 0.9)
        case "psychic": return Color.pink
        case "bug": return Color(red: 0.76, green: 0.88, blue: 0.19)
        case "rock": return Color(red: 0.4, green: 0.4, blue: 0.4)
        case "ghost": return Color.indigo
        case "dragon": return Color(red: 0.78, green: 0.04, blue: 0.82)
        case "dark": return Color.black
        case "steel": return Color.gray.opacity(0.8)
        case "fairy": return Color(red: 0.97, green: 0.56, blue: 0.65)
        case "shadow": return Color.black.opacity(0.7)
        default: return Color.white
        }
    }
}
