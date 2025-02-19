//
//  ContentView.swift
//  TaskFlow4.3
//
//  Created by Joseph DeWeese on 2/15/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
   
    
    var body: some View {
        ItemsScreen()
        }
    }
    
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
