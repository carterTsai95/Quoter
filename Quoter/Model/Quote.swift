//
//  Quote.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-16.
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


struct Quote: Codable, Identifiable, Hashable{
    
    var id: UUID? {return UUID()}
    var text: String?
    var author: String?
    var tag: String?

    
    
    var favorite: Bool?
    
    var displayFavorite: Bool {
        return favorite ?? false
    }
    
    static let allResorts: [Quote] = Bundle.main.decode("Quotes.json")
    
}


extension Quote {
    enum tag: String, CaseIterable{
        case general
        case attitude
        case beauty
        case best
        case marriage
        case medical
        case men
        case mom
        case money
        case morning
        case motivational
        case movies
        case music
        case nature
        case parenting
        case patience
        case patriotism
        case peace
    }
}


/*
 



 Author: Christian Bale
 Text: I met my grandfather just before he died, and it was the first time that I had seen Dad with a relative of his. It was interesting to see my own father as a son and the body language and alteration in attitude that comes with that, and it sort of changed our relationship for the better.
 Tag: attitude
 -------------
 Author: Nick Lowe
 Text: Elvis Costello had a brand new bag. He was a musician, but he knew all about the attitude part of it.
 Tag: attitude
 -------------
 Author:
 Text: For success, attitude is equally as important as ability.
 Tag: attitude

 
 
 */

let UserQuotes = [

    Quote(text: "To know oneself, one should assert oneself.", author: "Albert Camus" , tag: "motivational", favorite: true),
    Quote(text: "Well done is better than well said.", author: "Benjamin Franklin" , tag: "motivational", favorite: false),
    Quote(text: " If you want to succeed you should strike out on new paths, rather than travel the worn paths of accepted success.", author: "John D. Rockefeller" , tag: "motivational", favorite: false),
    Quote(text: "I met my grandfather just before he died, and it was the first time that I had seen Dad with a relative of his. It was interesting to see my own father as a son and the body language and alteration in attitude that comes with that, and it sort of changed our relationship for the better.", author: "Christian Bale" , tag: "attitude", favorite: true),
    Quote(text: "Elvis Costello had a brand new bag. He was a musician, but he knew all about the attitude part of it.", author: "Nick Lowe" , tag: "attitude", favorite: false),
    Quote(text: "For success, attitude is equally as important as ability.", author: "Walter Scott" , tag: "attitude", favorite: true),
]

