//
//  CardView.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 2/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//

import SwiftUI

struct CardView: View {
    private struct Constants {
        static let cornerRaidus: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScaleFactor: CGFloat = 0.75
    }
    
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { self.body(for: $0.size) }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFacingUp {
                RoundedRectangle(cornerRadius: Constants.cornerRaidus).foregroundColor(.white)
                RoundedRectangle(cornerRadius: Constants.cornerRaidus).stroke(lineWidth: Constants.lineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: Constants.cornerRaidus).fill()
                }
            }
        }
        .font(Font.system(size: min(size.width, size.height) * Constants.fontScaleFactor))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(isFacingUp: true, isMatched: false, content: "🥰", id: 1))
    }
}
