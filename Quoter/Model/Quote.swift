//
//  Quote.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-16.
//

import Foundation

struct Quote: Codable {
    var text: String?
    var author: String?
    var tag: String?
    
    var favorite: Bool?
    
    var displayFavorite: Bool {
        return favorite ?? false
    }
    
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

