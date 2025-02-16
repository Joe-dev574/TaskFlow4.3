//
//  Item.swift
//  TaskFlow4.3
//
//  Created by Joseph DeWeese on 2/15/25.
//

import SwiftUI
import SwiftData

@Model
final class Item {
    /// Properties
    var title: String
    var remarks: String
    var dateAdded: Date = Date.now
    var dateStarted: Date = Date.now
    var dateDue: Date = Date.now
    var dateCompleted: Date = Date.now
    var category: String
    
  
    
    init(
        title: String = "",
        remarks: String = "",
        dateAdded: Date = Date.now,
        dateDue: Date = Date.now,
        dateStarted: Date = Date.now,
        dateCompleted: Date = Date.now,
        category: Category
    ) {
        self.title = title
        self.remarks = remarks
        self.dateAdded = dateAdded
        self.dateDue = dateDue
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.category = category.rawValue
    }
   
    }

