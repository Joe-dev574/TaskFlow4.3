//
//  ItemCardView.swift
//  Flow
//
//  Created by Joseph DeWeese on 1/31/25.
//

import SwiftUI
import SwiftData




struct ItemCardView: View {
    @Environment(\.modelContext) private var context
    let item: Item
    
    var body: some View {
        NavigationStack{
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial.opacity(.greatestFiniteMagnitude))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack(alignment: .leading){
                    
                    HStack(spacing: 12){
                        
                        ZStack {
                            ///category tag
                            Text(item.category)
                                .padding(4)
                                .foregroundStyle(.white)
                                .contentShape(.rect)
                                .fontDesign(.serif)
                                .fontWeight(.semibold)
                                .font(.system(size: 14))
                                .padding(.leading, 150)
                                .shadow(color: .black, radius: 2, x: 2, y: 2)
                        }
                    }
                    //MARK:  MAIN BODY
                    HStack{
                        //MARK:  ICON
                        Text("\(String(item.title.prefix(1)))")
                            .font(.title)
                            .fontDesign(.serif)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                            .frame(width: 35, height: 35)
                            .background(.lightBlue.gradient.opacity(0.8))
                            .padding(5)
                        Text(item.title)
                            .font(.system(size: 18))
                            .fontDesign(.serif)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                    }
                    HStack{
                        Spacer()
                        //MARK:  DATE CREATED DATA LINE
                        Text("Date Created: ")
                            .foregroundStyle(.gray)
                            .fontDesign(.serif)
                            .font(.system(size: 12))
                        Image(systemName: "calendar.badge.clock")
                            .font(.footnote)
                            .fontDesign(.serif)
                            .foregroundStyle(.gray)
                            .font(.system(size: 12))
                        Text(item.dateAdded.formatted(.dateTime))
                            .fontDesign(.serif)
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))
                        Spacer()
                    }
                    .fontWeight(.semibold)
                    .padding(.horizontal, 4)
                    .padding(.bottom, 4)
                    //MARK:  BRIEF DESCRIPTION
                    if !item.remarks.isEmpty {
                        Text(item.remarks)
                            .fontDesign(.serif)
                            .font(.system(size: 14))
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 4)
                            .lineLimit(3)
                            .padding(.bottom, 4)
                    }
                }
            }///overlay
            .padding(4)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(.linearGradient(Gradient(colors: [Color.launchAccent, Color.blue, Color.orange]), startPoint: .leading, endPoint: .trailing), lineWidth: 2))
            
        }
    }
}
    

