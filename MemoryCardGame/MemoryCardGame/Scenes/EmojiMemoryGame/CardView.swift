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
    }
    
    var card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            if card.isFacingUp {
                RoundedRectangle(cornerRadius: Constants.cornerRaidus).foregroundColor(.green)
                RoundedRectangle(cornerRadius: Constants.cornerRaidus).stroke(lineWidth: Constants.lineWidth)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRaidus)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(isFacingUp: true, isMatched: false, content: "🥰", id: 1))
    }
}
