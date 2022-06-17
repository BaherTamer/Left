//
//  Card.swift
//  Left
//
//  Created by Baher Tamer on 15/06/2022.
//

import Foundation
import SwiftUI

struct Card: Hashable, Identifiable, Codable {
    var id = UUID()
    var emoji: String
    var title: String
    var date: Date
    var color: Color
}
