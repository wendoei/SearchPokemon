//
//  SearchBarView.swift
//  SearchPokemon
//
//  Created by jihye kim on 04/07/2024.
//

import SwiftUI

struct SearchBarView: View {
    @State private var isEditing: Bool = false
    @State private var cancelButtonColor = Constants.Colors.cancelButtonDefault
    @FocusState private var isTextFieldFocused: Bool
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: Constants.Icons.search)
                    .foregroundColor(.gray)
                
                TextField(Constants.searchBarPlaceholder, text: $searchText)
                    .autocapitalization(.none)
                    .keyboardType(.asciiCapable)
                    .focused($isTextFieldFocused)
                    .onTapGesture {
                        cancelButtonColor = Constants.Colors.cancelButtonDefault
                        withAnimation(.easeOut(duration: 0.1)) {
                            isEditing = true
                        }
                    }
                    .accessibilityHint(Constants.VoiceOver.searchTextFieldHint)

                
                if !searchText.isEmpty {
                    ClearButton(searchText: $searchText)
                        .accessibilityLabel(Constants.VoiceOver.clearButtonLabel)
                        .accessibilityHint(Constants.VoiceOver.clearButtonHint)
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Constants.Colors.searchBarBackground)
            )
            
            if isEditing {
                Button(action: {
                    searchText = ""
                    isTextFieldFocused = false
                    cancelButtonColor = Constants.Colors.cancelButtonHidden
                    withAnimation(.easeOut(duration: 0.1)) {
                        isEditing = false
                    }
                }) {
                    Text(Constants.cancelButtonTitle)
                        .foregroundColor(cancelButtonColor)
                }
                .transition(.move(edge: .trailing))
                .accessibilityLabel(Constants.VoiceOver.cancelButtonLabel)
                .accessibilityHint(Constants.VoiceOver.cancelButtonHint)
            }
        }
    }
    
    struct ClearButton: View {
        @Binding var searchText: String

        var body: some View {
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: Constants.Icons.xmark)
                    .foregroundColor(.gray)
            }
        }
    }
}

extension SearchBarView {
    private enum Constants {
        static let cancelButtonTitle = "Cancel"
        static let searchBarPlaceholder = "type Pokémon name"
        
        enum Icons {
            static let search = "magnifyingglass"
        }
        
        enum Colors {
            static let searchBarBackground = Color.gray.opacity(0.15)
            static let cancelButtonDefault = Color.blue
            static let cancelButtonHidden = Color.clear
        }
        
        enum VoiceOver {
            static let searchTextFieldHint = "Enter the name of the Pokémon you want to search for."
            static let clearButtonLabel = "Clear button"
            static let clearButtonHint = "Clears the search field"
            static let cancelButtonLabel = "Cancel button"
            static let cancelButtonHint = "Clears the search field and closes the keyboard"
        }
    }
}

extension SearchBarView.ClearButton {
    private enum Constants {
        enum Icons {
            static let xmark = "xmark.circle.fill"
        }
    }
}
