//
//  PokemonRow.swift
//  SearchPokemon
//
//  Created by jihye kim on 04/07/2024.
//

import SwiftUI

struct PokemonRow: View {
    var pokemon: Pokemon
    
    var body: some View {
        ZStack {
            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                EmptyView()
            }
            .opacity(0)
            
            HStack {
                VStack(alignment: .leading){
                    Text(String(format: Constants.Formats.id, pokemon.id))
                        .font(.caption)
                        .fontWeight(.bold)
                        .opacity(0.4)
                    
                    Text(pokemon.name.capitalized)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    HStack {
                        ForEach(pokemon.types, id: \.type.name) { typeInfo in
                            TypeCapsuleView(typeName: typeInfo.type.name)
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    AsyncImage(url: pokemon.sprites.backDefault) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(
                        width: Constants.Size.rawImage,
                        height: Constants.Size.rawImage
                    )
                }
                .frame(
                    width: Constants.Size.imageFrame,
                    height: Constants.Size.imageFrame
                )
            }
        }
    }
}

extension PokemonRow {
    private enum Constants {
        enum Formats {
            static let id = "#%04d"
        }
        
        enum Size {
            static let rawImage = CGFloat(250)
            static let imageFrame = CGFloat(80)
        }
    }
}
