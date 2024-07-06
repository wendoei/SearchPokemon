//
//  PokemonImageCarouselView.swift
//  SearchPokemon
//
//  Created by jihye kim on 04/07/2024.
//

import SwiftUI

struct PokemonImageCarouselView: View {
    @State private var currentPage = 0
    var imageDetails: [ImageDetail]

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<imageDetails.count, id: \.self) { index in
                let imageDetail = imageDetails[index]
                AsyncImage(url: imageDetail.url) { phase in
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
                .tag(index)
                .accessibilityLabel(imageDetail.description)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: Constants.Size.frame)
        .background(
            Image(.pokemonBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .accessibilityLabel(Constants.VoiceOver.backgroundImageLabel)
        )
        .clipped()
        .onChange(of: currentPage) { _, newPage in
            let description = imageDetails[newPage].description
            UIAccessibility.post(notification: .announcement, argument: description)
        }
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
        
        enum VoiceOver {
            static let backgroundImageLabel = """
                A serene view of a lush green grassy hill leading down to a clear blue sea
            """
        }
    }
}
