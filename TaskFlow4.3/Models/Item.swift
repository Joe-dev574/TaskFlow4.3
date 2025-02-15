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
    var status: Status.RawValue = Status.Upcoming.rawValue
  
    
    init(
        title: String = "",
        remarks: String = "",
        dateAdded: Date = Date.now,
        dateDue: Date = Date.now,
        dateStarted: Date = Date.now,
        dateCompleted: Date = Date.now,
        category: Category,
        status: Status = .Upcoming
       
    ) {
        self.title = title
        self.remarks = remarks
        self.dateAdded = dateAdded
        self.dateDue = dateDue
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.category = category.rawValue
        self.status = status.rawValue
       
    }
    var icon: Image {
        switch Status(rawValue: status)! {
        case .Upcoming:
            Image(systemName: "checkmark.diamond.fill")
        case .Active:
            Image(systemName: "item.fill")
        case .Completed:
            Image(systemName: "books.vertical.fill")
        }
    }

    @Transient
    var rawStatus: Status? {
        return Status.allCases.first(where: { status == $0.rawValue })
    }
}
    enum Status: Int, Codable, Identifiable, CaseIterable {
        case Upcoming, Active, Completed
        var id: Self {
            self
        }
        var descr: LocalizedStringResource {
            switch self {
            case .Upcoming:
                "Upcoming"
            case .Active:
                "Active"
            case .Completed:
                "Completed"
            }
        }
    }

