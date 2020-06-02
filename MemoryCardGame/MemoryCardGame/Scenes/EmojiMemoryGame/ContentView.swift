//
//  ContentView.swift
//  MemoryCardGame
//
//  Created by Shawn Sun on 2/6/20.
//  Copyright © 2020 Shawn Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card)
                }
            }
        .padding()
            .foregroundColor(.orange)
            .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
