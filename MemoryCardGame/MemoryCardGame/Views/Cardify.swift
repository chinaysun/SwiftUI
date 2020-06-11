//
//  Cardify.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 11/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    private struct Constants {
        static let cornerRaidus: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScaleFactor: CGFloat = 0.75
    }
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: Constants.cornerRaidus).foregroundColor(.white)
                RoundedRectangle(cornerRadius: Constants.cornerRaidus).stroke(lineWidth: Constants.lineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRaidus).fill()
            }
        }
    }
}

extension View {
    
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
