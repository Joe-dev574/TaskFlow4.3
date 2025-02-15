//
//  ItemEditView.swift
//  TaskFlow2.3
//
//  Created by Joseph DeWeese on 2/13/25.
//


import SwiftUI

struct ItemEditView: View {
    // Environment for managing object context in Core Data
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let item: Item
    
   
    @State private var title = ""
    @State private var remarks = ""
    @State private var dateAdded = Date.now
    @State private var dateDue = Date.now
    @State private var dateStarted = Date.now
    @State private var dateCompleted = Date.now
    @State private var firstView = true
    @State private var recommendedBy = ""
    @State private var showTags = false
    @State private var category = Category.today
    
    
    var body: some View {
        HStack {
            CategoryCheckBox(category: $category)
        }
        
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                if category == .today || category == .complete {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                if category == .complete {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .onChange(of: category) { oldValue, newValue in
                if !firstView {
                    if newValue == .upcoming{
                        dateStarted = Date.distantPast
                        dateDue = Date.distantFuture
                    } else if newValue == .upcoming && oldValue == .complete {
                        // from completed to inProgress
                        dateCompleted = Date.distantPast
                    } else if newValue == .today && oldValue == .upcoming {
                        // Book has been started
                        dateStarted = Date.now
                    } else if newValue == .complete && oldValue == .upcoming {
                        // Forgot to start book
                        dateCompleted = Date.now
                        dateStarted = dateAdded
                    } else {
                        // completed
                        dateCompleted = Date.now
                    }
                    firstView = false
                }
            }
            Divider()
            
            ScrollView(.vertical) {
                VStack(spacing: 15) {
                    //MARK:  DATE PICKER GROUP
                    Section("Timeline") {
                        GroupBox{
                            HStack{
                                //MARK:  DATE CREATED DATA LINE
                                Text("Date Created: ")
                                    .foregroundStyle(.primary)
                                    .fontDesign(.serif)
                                    .font(.callout)
                                Spacer()
                                Image(systemName: "calendar.badge.clock")
                                    .fontDesign(.serif)
                                    .foregroundStyle(.primary)
                                    .font(.system(size: 14))
                                Text(dateAdded.formatted(.dateTime))
                                    .fontDesign(.serif)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 14))
                            }
                        }
                    }
                            ///title
                            Section("Title") {
                                ZStack(alignment: .topLeading) {
                                    if title.isEmpty {
                                        Text("Enter title here...")
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(3)
                                            .padding(10)
                                            .fontDesign(.serif)
                                            .foregroundStyle(.secondary)
                                    }
                                    TextEditor(text: $title)
                                        .scrollContentBackground(.hidden)
                                        .background(Color.gray.opacity(0.1))
                                        .font(.system(size: 16))
                                        .fontDesign(.serif)
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color.secondary, lineWidth: 1))
                            }
                            .padding(.horizontal, 7)
                            ///description
                            Section("Brief Description") {
                                ZStack(alignment: .topLeading) {
                                    if remarks.isEmpty {
                                        Text("Brief description here...")
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(3)
                                            .padding(10)
                                            .foregroundStyle(.secondary)
                                    }
                                    TextEditor(text: $remarks)
                                        .scrollContentBackground(.hidden)
                                        .background(Color.gray.opacity(0.1))
                                        .font(.system(size: 16))
                                        .fontDesign(.serif)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 7)
                                                .stroke(Color.gray, lineWidth: 1))
                                }
                            }
                            .fontDesign(.serif)
                            .background(.background)
                        }  .padding(.horizontal, 7)
                    }
                    .padding(.horizontal, 10)
                    .fontDesign(.serif)
                    .padding(5)
                    }
                    HStack {
                        Button("Tags", systemImage: "bookmark.fill") {
                            showTags.toggle()
                        }
                        .sheet(isPresented: $showTags) {
                            TagView()
                        }
                    }
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        if changed {
                            Button("Update") {
                                item.category = category.rawValue
                                item.title = title
                                item.remarks = remarks
                                item.dateAdded = dateAdded
                                item.dateStarted = dateStarted
                                item.dateCompleted = dateCompleted
                                
                                dismiss()
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .onAppear {
                        category = Category(rawValue: item.category)!
                        title = item.title
                        remarks = item.remarks
                        dateAdded = item.dateAdded
                        dateStarted = item.dateStarted
                        dateCompleted = item.dateCompleted
                    }
                }
                
                var changed: Bool {
                    category != Category(rawValue: item.category)!
                    || title != item.title
                    || remarks != item.remarks
                    || dateAdded != item.dateAdded
                    || dateStarted != item.dateStarted
                    || dateCompleted != item.dateCompleted
                }
                }
            
      
#Preview {
    let preview = Preview(Item.self)
   return  NavigationStack {
       ItemEditView(item: Item.sampleItems[4])
           .modelContainer(preview.container)
    }
}
