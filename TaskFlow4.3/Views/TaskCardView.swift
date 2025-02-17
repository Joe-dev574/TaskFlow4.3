//
//  TaskCardView.swift
//  TaskFlow4.3
//
//  Created by Joseph DeWeese on 2/16/25.
//

import SwiftUI
import SwiftData

enum TaskCellEvents {
    case onChecked(ItemTask, Bool)
    case onSelect(ItemTask)
}

struct TaskCardView: View {
    
    let itemTask: ItemTask
   let onEvent: (TaskCellEvents) -> Void
    @State private var checked: Bool = false
    
    private func formatTaskDate(_ date: Date) -> String {
        
        if date.isToday {
            return "Today"
        } else if date.isTomorrow {
            return "Tomorrow"
        } else {
            return date.formatted(date: .numeric, time: .omitted)
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            
            Image(systemName: checked ? "circle.inset.filled": "circle")
                .font(.title2)
                .padding([.trailing], 5)
                .onTapGesture {
                    checked.toggle()
                    onEvent(.onChecked(itemTask, checked))
                }
            
            VStack {
                Text(itemTask.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    if let taskDate = itemTask.taskDate {
                        Text(formatTaskDate(taskDate))
                    }
                    
                    if let taskTime = itemTask.taskTime {
                        Text(taskTime, style: .time)
                    }
                    
                }.font(.caption)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
        }.contentShape(Rectangle())
            .onTapGesture {
                onEvent(.onSelect(itemTask))
            }
    }
}

struct TaskCellViewContainer: View {
    
    @Query(sort: \ItemTask.name) private var itemTasks: [ItemTask]
    
    var body: some View {
        TaskCardView(itemTask: itemTasks[0]) { _ in
            
        }
    }
}

#Preview { @MainActor in
    TaskCellViewContainer()
   
      
}
