//
//  Favorite.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-05-05.
//

import Foundation

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    var quotes: Set<Quote>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data

        // still here? Use an empty array
        self.quotes = []
    }

    // returns true if our set contains this resort
    func contains(_ quote: Quote) -> Bool {
        
        quotes.contains(quote)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ quote: Quote) {
        objectWillChange.send()
        quotes.insert(quote)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ quote: Quote) {
        objectWillChange.send()
        quotes.remove(quote)
        save()
    }

    func save() {
        // write out our data
    }
}
