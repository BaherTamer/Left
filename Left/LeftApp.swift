//
//  LeftApp.swift
//  Left
//
//  Created by Baher Tamer on 15/06/2022.
//

import SwiftUI

@main
struct LeftApp: App {
    @StateObject private var cardsViewModel = CardsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cardsViewModel)
        }
    }
}
