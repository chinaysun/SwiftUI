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
        static let fontScaleFactor: CGFloat = 0.75
    }

    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { self.body(for: $0.size) }
    }

    @State private var animatedBonusRemaining: Double = 0

    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFacingUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: .degrees(-90), endAngle: .degrees(-animatedBonusRemaining * 360 - 90), clockwise: true)

                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: .degrees(-90), endAngle: .degrees(-card.bonusRemaining * 360 - 90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)

                Text(card.content)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFacingUp)
            .font(Font.system(size: min(size.width, size.height) * Constants.fontScaleFactor))
            .transition(.scale)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .init(isFacingUp: true, isMatched: false, content: "🥰", id: 1))
    }
}
