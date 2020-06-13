//
//  Cardify.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 11/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    private struct Constants {
        static let cornerRaidus: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScaleFactor: CGFloat = 0.75
    }
    
    var rotation: Double
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: Constants.cornerRaidus).foregroundColor(.white)
                RoundedRectangle(cornerRadius: Constants.cornerRaidus).stroke(lineWidth: Constants.lineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: Constants.cornerRaidus).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
