//
//  TaskEditScreen.swift
//  TaskFlow4.3
//
//  Created by Joseph DeWeese on 2/17/25.
//

import SwiftUI
import SwiftData

struct TaskEditScreen: View {
    let itemTask: ItemTask
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var taskDate: Date = .now
    @State private var taskTime: Date = .now
    
    @State private var showCalender: Bool = false
    @State private var showTime: Bool = false
    
    private func updateReminder() {
        itemTask.name = name
        itemTask.taskDate = showCalender ? taskDate: nil
        itemTask.taskTime = showTime ? taskTime: nil
        
        //        // schedule a local notification
        //        NotificationManager.scheduleNotification(userData: UserData(name: itemTask.name, body: reminder.notes, date: reminder.reminderDate, time: reminder.reminderTime))
    }
    
    private var isFormValid: Bool {
        !name.isEmptyOrWhitespace
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name..", text: $name)
                
                
                Section {
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.red)
                            .font(.title2)
                        
                        Toggle(isOn: $showCalender) {
                            EmptyView()
                        }
                    }
                    
                    if showCalender {
                        
                        DatePicker("Select Date", selection: $taskDate, in: .now..., displayedComponents: .date)
                    }
                    
                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(.blue)
                            .font(.title2)
                        Toggle(isOn: $showTime) {
                            EmptyView()
                        }
                    }.onChange(of: showTime) {
                        if showTime {
                            showCalender = true
                        }
                    }
                    
                    if showTime {
                        DatePicker("Select Time", selection: $taskTime, displayedComponents: .hourAndMinute)
                        
                    }
                    
                }
                
            }.onAppear(perform: {
                name = itemTask.name
                taskDate = itemTask.taskDate ?? Date()
                taskTime = itemTask.taskTime ?? Date()
                showCalender = itemTask.taskTime != nil
                showTime = itemTask.taskTime != nil
            })
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        updateReminder()
                        dismiss()
                    }.disabled(!isFormValid)
                }
            }
        }
    }
    
    struct TaskEditScreenContainer: View {
        
        @Query(sort: \ItemTask.name) private var itemTasks: [ItemTask]
        
        var body: some View {
            TaskEditScreen(itemTask: itemTasks[0])
        }
    }
}
//#Preview {
//    NavigationStack {
//        TaskEditScreenContainer()
//    }.modelContainer(previewContainer)
//}
