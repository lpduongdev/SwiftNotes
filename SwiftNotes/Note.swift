//
//  Item.swift
//  SwiftNotes
//
//  Created by Lương Dương on 19/09/2023.
//

import Foundation
import SwiftData

@Model
final class Note {
    @Attribute(.unique) let id: String = UUID().uuidString
    var content: String
    var timestamp: Date
    
    init(content: String, timestamp: Date) {
        self.content = content
        self.timestamp = timestamp
    }
}
