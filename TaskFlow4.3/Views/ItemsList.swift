//
//  ItemsList.swift
//  TaskFlow2.3
//
//  Created by Joseph DeWeese on 2/13/25.
//

import SwiftUI
import SwiftData


struct ItemsList: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [Item]
    @State private var activeTab: Category = .today
    
    // Computed property to filter and sort items based on the active tab
    private var filteredItems: [Item] {
        switch activeTab {
        case .today:
            return items.filter { $0.category == "Today" }.sorted { $0.dateDue < $1.dateDue }
        case .upcoming:
            return items.filter { $0.category == "Upcoming" }.sorted { $0.dateAdded < $1.dateAdded }
        case .ideas:
            return items.filter { $0.category == "Ideas" }.sorted { $0.title < $1.title }
        case .recurringDates:
            return items.filter { $0.category == "Dates!" }.sorted { $0.dateAdded < $1.dateAdded }
        case .completed:
            return items.filter { $0.category == "Complete"  }.sorted { $0.dateCompleted < $1.dateCompleted }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                CustomTabBar(activeTab: $activeTab)
                    LazyVStack(alignment: .leading) {
                        // Dynamic text based on the selected tab
                        Text(activeTab.rawValue + (activeTab == .recurringDates ? " Thou Shalt Not Forget! " : " Shit"))
                            .font(.title3)
                            .fontDesign(.serif)
                            .foregroundColor(.gray)
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(filteredItems) { item in
                            NavigationLink{
                               ItemEditView(item: item)
                            } label: {
                              ItemCardView(item: item)
                                    .padding(.horizontal, 12)
                            }
                        }
                        
                      }
                        }
                    }
            }
            }
    
    

#Preview {
    ItemsList()
}
