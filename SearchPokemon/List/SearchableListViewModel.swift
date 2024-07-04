//
//  SearchableListViewModel.swift
//  SearchPokemon
//
//  Created by jihye kim on 02/07/2024.
//

import Alamofire
import Combine
import Foundation

class PokemonViewModel: ObservableObject {
    private let apiString = "https://pokeapi.co/api/v2/pokemon/"
    private let decoder = JSONDecoder()
    
    private var cancellable: AnyCancellable?
    private var cachedPokemons: [Pokemon] = []
    
    @Published var searchText = ""
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false
    @Published var showNoResults = false
    
    deinit {
        cancellable?.cancel()
    }
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map { $0.lowercased() }
            .removeDuplicates()
            .sink(receiveValue: { [weak self] text in
                guard let self else { return }
                
                if text.isEmpty {
                    self.pokemons = self.cachedPokemons
                    self.showNoResults = false
                } else {
                    self.fetchPokemon(name: text)
                }
            })
    }
    
    func fetchPokemon(name: String) {
        isLoading = true
        Task {
            let response = await AF.request(apiString + name).serializingDecodable(
                Pokemon.self,
                decoder: decoder
            ).response
            
            await MainActor.run { [weak self] in
                self?.isLoading = false
                if let pokemon = response.value {
                    if let index = self?.cachedPokemons.firstIndex(of: pokemon) {
                        self?.cachedPokemons.remove(at: index)
                    }
                    
                    self?.pokemons = [pokemon]
                    self?.cachedPokemons.insert(pokemon, at: 0)
                    self?.showNoResults = false
                } else {
                    self?.pokemons = []
                    self?.showNoResults = true
                }
            }
        }
    }
}
