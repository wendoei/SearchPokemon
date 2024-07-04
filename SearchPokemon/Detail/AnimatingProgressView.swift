//
//  AnimatingProgressView.swift
//  SearchPokemon
//
//  Created by jihye kim on 04/07/2024.
//

import SwiftUI

struct AnimatingProgressView: View {
    private let duration: Double = 1
    var value: Double
    var total: Double
    var color: Color
    
    @State private var progress = 0.0
    
    var body: some View {
        ZStack(alignment: .leading) {
            ProgressView(value: progress, total: total)
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
            
            Text("\(Int(progress))")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.leading, 5)
        }.onAppear {
            Task { @MainActor in
                withAnimation {
                    progress = value
                }
            }
        }
    }
}
