//
//  CardListView.swift
//  Left
//
//  Created by Baher Tamer on 15/06/2022.
//

import SwiftUI

struct CardListView: View {
    @EnvironmentObject var cardsViewModel: CardsViewModel

    @State private var showingAddCardView = false

    var body: some View {
        List {
            ForEach(cardsViewModel.cards) { card in
                ZStack {
                    NavigationLink {
                        CardDetails(card: card)
                    } label: {
                    }
                    .buttonStyle(PlainButtonStyle())
                    .opacity(0)

                    CardView(card: card)
                }
            }
            .onDelete(perform: cardsViewModel.deleteCard)
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("⧖ LEFT")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddCardView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                }
            }
        }
        .sheet(isPresented: $showingAddCardView) {
            AddCardView()
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardListView()
                .environmentObject(CardsViewModel())
        }
    }
}
