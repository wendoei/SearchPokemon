//
//  SearchableListView.swift
//  SearchPokemon
//
//  Created by jihye kim on 02/07/2024.
//

import SwiftUI

struct SearchableListView: View {
    @StateObject private var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $viewModel.searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                
                ZStack {
                    List(viewModel.pokemons, id: \.name) { pokemon in
                        PokemonRow(pokemon: pokemon)
                    }
                    .listRowSpacing(10)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.systemBackground))
                            .edgesIgnoringSafeArea(.all)
                    }
                    
                    if viewModel.showNoResults {
                        Text(Constants.noResultFound)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(.systemBackground))
                            .edgesIgnoringSafeArea(.all)
                    }
                }
            }
        }
    }
}

extension SearchableListView {
    private enum Constants {
        static let noResultFound = "No results found"
        static let searchBarPlaceholder = "Search Pokémon"
        
        enum Icons {
            static let search = "magnifyingglass"
        }
        
        enum Colors {
            static let searchBarBackground = Color.gray.opacity(0.15)
        }
    }
}

#Preview {
    SearchableListView()
}
