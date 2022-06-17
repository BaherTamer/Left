//
//  CardsViewModel.swift
//  Left
//
//  Created by Baher Tamer on 15/06/2022.
//

import Foundation
import SwiftUI

class CardsViewModel: ObservableObject {
    @Published var cards: [Card]

    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
                return
            }
        }

        cards = []
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        }
    }

    func getYear(date: Date) -> Int {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now, to: date).year ?? 0
    }

    func getMonth(date: Date) -> Int {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now, to: date).month ?? 0
    }

    func getDay(date: Date) -> Int {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now, to: date).day ?? 0
    }

    func getHour(date: Date) -> Int {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now, to: date).hour ?? 0
    }

    func getMinute(date: Date) -> Int {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now, to: date).minute ?? 0
    }

    func getSecond(date: Date) -> Int {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now, to: date).second ?? 0
    }

    func addCard(emoji: String, title: String, date: Date, color: Color) {
        cards.append(Card(emoji: emoji, title: title, date: date, color: color))
        save()
    }

    func deleteCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        save()
    }

    func editCard(id: UUID, emoji: String, title: String, date: Date, color: Color) {
        let newCard = Card(id: id, emoji: emoji, title: title, date: date, color: color)

        guard let index = getCardIndex(id: id) else {
            return
        }

        cards[index] = newCard
        save()
    }

    func getCardIndex(id: UUID) -> Int? {
        cards.firstIndex(where: { $0.id == id })
    }

    func dateShortFormat(card: Card) -> String {
        let year = Calendar.current.dateComponents([.year], from: .now, to: card.date).year ?? 0
        let month = Calendar.current.dateComponents([.month], from: .now, to: card.date).month ?? 0
        let day = Calendar.current.dateComponents([.day], from: .now, to: card.date).day ?? 0
        let hour = Calendar.current.dateComponents([.hour], from: .now, to: card.date).hour ?? 0
        let minute = Calendar.current.dateComponents([.minute], from: .now, to: card.date).minute ?? 0
        let second = Calendar.current.dateComponents([.second], from: .now, to: card.date).second ?? 0

        if year > 0 {
            return year == 1 ? "1 Year Left" : "\(year) Years Left"
        } else if month > 0 {
            return month == 1 ? "1 Month Left" : "\(month) Months Left"
        } else if day > 0 {
            return day == 1 ? "1 Day Left" : "\(day) Days Left"
        } else if hour > 0 {
            return hour == 1 ? "1 Hour Left" : "\(hour) Hours Left"
        } else if minute > 0 {
            return minute == 1 ? "1 Minute Left" : "\(minute) Minutes Left"
        } else if second > 0 {
            return second == 1 ? "1 Second Left" : "\(second) Seconds Left"
        } else {
            return "Ended"
        }
    }
}
