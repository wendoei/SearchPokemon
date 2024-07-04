//
//  PokemonImageCarouselView.swift
//  SearchPokemon
//
//  Created by jihye kim on 04/07/2024.
//

import SwiftUI

struct PokemonImageCarouselView: View {
    var imageUrls: [URL]

    var body: some View {
        TabView {
            ForEach(imageUrls, id: \.self) { imageUrl in
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                        
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    case .failure:
                        Image(systemName: Constants.Icons.imageLoadFail)
                        
                    default:
                        EmptyView()
                    }
                }
                .frame(
                    width: Constants.Size.frame,
                    height: Constants.Size.frame
                )
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: Constants.Size.frame)
        .padding()
        .background(
            Image(.pokemonBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .clipped()
    }
}

extension PokemonImageCarouselView {
    private enum Constants {
        enum Icons {
            static let imageLoadFail = "photo"
        }
        
        enum Size {
            static let frame = CGFloat(300)
        }
    }
}
