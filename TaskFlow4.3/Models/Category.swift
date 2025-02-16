//
//  Category.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI

enum Category: String, CaseIterable {
    // Time-Based Categories
    case today = "Today"
    case upcoming = "Upcoming"
    case recurringDates = "Recurring Dates"
    
    // Status-Based Categories
    case completed = "Completed"
    
    // Planning Categories
    case ideas = "Ideas"
    
    var color: Color {
        switch self {
        // Time-Based Colors
        case .today: .darkBlue
        case .upcoming: .launchAccent
        case .recurringDates: Color.primary
        
        // Status-Based Colors
        case .completed: .green
        
        // Planning Colors
        case .ideas: .yellow
        }
    }
    
    var symbolImage: String {
        switch self {
        // Time-Based Symbols
        case .today: "alarm"
        case .upcoming: "calendar"
        case .recurringDates: "repeat"
        
        // Status-Based Symbols
        case .completed: "calendar.badge.checkmark"
        
        // Planning Symbols
        case .ideas: "lightbulb.max"
        }
    }
}
