//
//  Card.swift
//  Left
//
//  Created by Baher Tamer on 15/06/2022.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var cardsViewModel: CardsViewModel
    var card: Card

    var body: some View {
        GroupBox {
            Text(cardsViewModel.dateShortFormat(card: card))
                .font(.headline)
        } label: {
            Text("\(card.emoji) \(card.title)")
                .font(.title2)
                .fontWeight(.bold)
        }
        .groupBoxStyle(CardStyle(cardColor: card.color))
    }
}

struct CardStyle: GroupBoxStyle {
    var cardColor: Color

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 8) {
            configuration.label
            configuration.content
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(cardColor.opacity(0.16))
        .overlay(alignment: .leading) {
            Rectangle()
                .fill(cardColor)
                .frame(width: 8)
        }
        .overlay(alignment: .trailing) {
            Rectangle()
                .fill(cardColor)
                .frame(width: 8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(emoji: "🎂", title: "Baher's Birthday", date: .now, color: .blue))
            .previewLayout(.sizeThatFits)
            .environmentObject(CardsViewModel())
    }
}
