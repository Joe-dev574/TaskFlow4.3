//
//  Task.swift
//  TaskFlow4.3
//
//  Created by Joseph DeWeese on 2/16/25.
//

import Foundation
import SwiftData

@Model
class ItemTask {
    
    var name: String = ""
    var isCompleted: Bool = false
    var taskDate: Date?
    var taskTime: Date?
    
    var item:  Item?
    
    init(name: String, isCompleted: Bool = false, taskDate: Date? = nil, taskTime: Date? = nil ) {
        self.name = name
        self.isCompleted = isCompleted
        self.taskDate = taskDate
        self.taskTime = taskTime
       
    }
    
}

