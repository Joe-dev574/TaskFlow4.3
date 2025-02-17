//
//  TaskListView.swift
//  TaskFlow4.3
//
//  Created by Joseph DeWeese on 2/16/25.
//

import SwiftUI
import SwiftData


import SwiftUI
import SwiftData

struct TaskListView: View {
    
    let itemTasks: [ItemTask]
    @Environment(\.modelContext) private var context
    
    @State private var selectedTask: ItemTask? = nil
    @State private var showTaskEditScreen: Bool = false
    
    @State private var taskIdAndDelay: [PersistentIdentifier: Delay] = [: ]
    
    private func deleteTask(_ indexSet: IndexSet) {
        guard let index = indexSet.last else { return }
        let itemTask = itemTasks[index]
        context.delete(itemTask)
    }
    
    var body: some View {
        List {
            ForEach(itemTasks) { itemTask in
                TaskCardView(itemTask: itemTask) { event in
                    switch event {
                    case .onChecked(let itemTask, let checked):
                            
                        // get the delay from the dictionary
                        var delay = taskIdAndDelay[itemTask.persistentModelID]
                            if let delay {
                                // cancel
                                delay.cancel()
                                taskIdAndDelay.removeValue(forKey: itemTask.persistentModelID)
                                
                            } else {
                                // create a new delay and add to the dictionary
                                delay = Delay()
                                taskIdAndDelay[itemTask.persistentModelID] = delay
                                delay?.performWork {
                                    itemTask.isCompleted = checked
                                }
                            }
                            
                    case .onSelect(let itemTask): // for editing
                        selectedTask = itemTask
                    }
                }
            }.onDelete(perform: deleteTask)
        }.sheet(item: $selectedTask, content: { selectedTask in
            NavigationStack {
                TaskEditScreen(itemTask: selectedTask)
            }
        })
    }
}
