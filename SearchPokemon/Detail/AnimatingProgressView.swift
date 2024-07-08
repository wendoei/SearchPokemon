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
                .progressViewStyle(RoundedRectangleProgressViewStyle(color: color))
                .accessibilityHidden(true)
            
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

struct RoundedRectangleProgressViewStyle: ProgressViewStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let progress = configuration.fractionCompleted ?? 0
            let cornerRadius = height / 2
            
            return ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: width, height: height)
                    .foregroundColor(.gray.opacity(0.3))
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: CGFloat(progress) * width, height: height)
                    .foregroundColor(color)
                    .animation(.linear, value: progress)
            }
        }
    }
}
