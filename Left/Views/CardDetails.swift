//
//  CardDetails.swift
//  Left
//
//  Created by Baher Tamer on 15/06/2022.
//

import SwiftUI

struct CardDetails: View {
    @EnvironmentObject var cardsViewModel: CardsViewModel

    @State private var showingAddCardView = false

    var card: Card

    private var ColumnGrid = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
        ScrollView {
            GroupBox {
                Text(card.date.formatted(date: .numeric, time: .shortened))
                    .font(.title)
                    .fontWeight(.heavy)
            }
            .groupBoxStyle(CardStyle(cardColor: card.color))

            LazyVGrid(columns: ColumnGrid) {
                GroupBox("Years") {
                    Text("\(cardsViewModel.getYear(date: card.date))")
                }

                GroupBox("Months") {
                    Text("\(cardsViewModel.getMonth(date: card.date))")
                }

                GroupBox("Days") {
                    Text("\(cardsViewModel.getDay(date: card.date))")
                }

                GroupBox("Hours") {
                    Text("\(cardsViewModel.getHour(date: card.date))")
                }

                GroupBox("Minutes") {
                    Text("\(cardsViewModel.getMinute(date: card.date))")
                }

                GroupBox("Seconds") {
                    Text("\(cardsViewModel.getSecond(date: card.date))")
                }
            }
            .groupBoxStyle(DateBoxStyle(cardColor: card.color))
            .font(.body.bold())

            Spacer()
        }
        .padding()
        .navigationTitle(card.emoji + " " + card.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddCardView = true
                } label: {
                    Image(systemName: "pencil")
                        .font(.headline)
                }
            }
        }
        .sheet(isPresented: $showingAddCardView) {
            AddCardView(id: card.id, emoji: card.emoji, title: card.title, color: card.color, date: card.date)
        }
    }

    init(card: Card) {
        self.card = card
    }
}

private struct DateBoxStyle: GroupBoxStyle {
    var cardColor: Color

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 8) {
            configuration.label
            configuration.content
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(cardColor.opacity(0.16))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct CardDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardDetails(card: Card(emoji: "🎂", title: "Baher's Birthday", date: .now, color: .blue))
                .environmentObject(CardsViewModel())
        }
    }
}
