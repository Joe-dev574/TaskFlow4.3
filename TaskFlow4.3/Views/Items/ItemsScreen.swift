//
//  ItemsScreen.swift
//  TaskFlow4.3
//
//  Created by Joseph DeWeese on 2/15/25.
//

import SwiftUI
import SwiftData

/// A view that displays a list of items and provides functionality to add new items.
struct ItemsScreen: View {
    // Environment for managing object context in Core Data
    @Environment(\.modelContext) private var modelContext
    
    // State for controlling the visibility of the add item sheet
    @State private var showAddItemSheet: Bool = false
    
    var body: some View {
    
        NavigationStack {
            VStack(alignment: .leading, spacing: 4) {
                ItemsList()
            }
            //MARK:  TOOL BAR
            .toolbar {
                // MARK: Toolbar Configuration
                ToolbarItem(placement: .topBarLeading) {
                    // Button to navigate to user's profile
                    Button(action: {
                        print("Navigating to profile")
                        // Haptic feedback for success action (commented out)
                        HapticsManager.notification(type: .success)
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.blue.opacity(0.6))
                    }
                }
                ToolbarItem(placement: .principal) {
                    // Central logo or title of the app
                    LogoView()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    // Button to add a new item
                    Button(action: {
                        showAddItemSheet = true
                        // Haptic feedback for successful interaction
                        HapticsManager.notification(type: .success)
                    }) {
                        Image(systemName: "plus")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .frame(width: 35, height: 35)
                            .background(.oliveDrab.gradient, in: Circle())
                    }
                    .sheet(isPresented: $showAddItemSheet) {
                        AddItemView()
                            .presentationDetents([.large])
                    }
                }
            }
        }
        // Apply blur effect when the add item sheet is presented
        .blur(radius: showAddItemSheet ? 8 : 0)
    }
}
// MARK: - Preview Provider
#Preview {
    // Setting up preview with sample data
    let preview = Preview(Item.self)
    let items = Item.sampleItems
    preview.addExamples(items)
    
    return ItemsScreen()
        .modelContainer(preview.container)
}
