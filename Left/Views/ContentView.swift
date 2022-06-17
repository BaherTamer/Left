//
//  ContentView.swift
//  Left
//
//  Created by Baher Tamer on 15/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CardListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CardsViewModel())
    }
}
