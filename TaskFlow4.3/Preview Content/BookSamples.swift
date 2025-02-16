//
// Created for MyBooks
// by  Stewart Lynch on 2023-10-04
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import Foundation

extension Item {
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
    static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
    static var sampleItems: [Item] {
        [
            Item(title: "QBVII", remarks: "Leon Uris", category: .ideas),
            Item(title: "Macbeth",
                 remarks: "William Shakespear",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 category: .ideas),
            Item(title: "Silence of the Grave",
                 remarks: "Arnuldur Indrason, Bernard Scudder",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                 category: .upcoming),
            Item(title: "Cardinal",
                 remarks: "Giles Blunt", category: .upcoming),
            Item(title: "Jackdaws",
                 remarks: "Ken Follett",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 category: .ideas),
            Item(title: "Blackout",
                 remarks: "John Lawton",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                 category: .ideas),
            Item(title: "The Sandman",
                 remarks: "Lars Keplar", category: .ideas),
            Item(title: "The Redbreast",
                 remarks: "Jo Nesbo",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 category: .upcoming),
            Item(title: "Fatherland",
                 remarks: "Robert Harris",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 category: .ideas)
        ]
    }
}
