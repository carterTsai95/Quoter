//
//  Quote.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-16.
//

import Foundation

let jsonResponse = JsonResoponse()

struct ApiResponse: Codable{
    var message: String?
    var quotes: [Quote]?
}

class JsonResoponse
{
    
    func getQuotesByCategory(category: Quote.tag, completionHandler: @escaping ([Quote]) -> Void)
    {
        if let path = Bundle.main.path(forResource: "Quotes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                do {
                    
                    let ApiModel = try decoder.decode(ApiResponse.self, from: data)
                    
                    
                    let quotes = ApiModel.quotes!.filter { $0.tag == category.rawValue }
                    
//                    for quote in quotes.prefix(5){
//                        print(
//                            """
//                        Author: \(String(describing: quote.author))
//                        Text: \(String(describing: quote.text))
//                        Tag: \(String(describing: quote.tag))
//                        -------------
//                        """)
//                    }
                    
                    completionHandler(quotes)
                    
                    
                }catch{
                    print(error) // shows error
                    print("Decoding failed")// local message
                }
                
            } catch {
                print(error) // shows error
                print("Unable to read file")// local message
            }
        }
    }

    func getAllQuotes(completionHandler: @escaping ([Quote]) -> Void)
    {
        if let path = Bundle.main.path(forResource: "Quotes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                do {
                    
                    let ApiModel = try decoder.decode(ApiResponse.self, from: data)
                                
                    completionHandler(ApiModel.quotes!)
                    
                    
                }catch{
                    print(error) // shows error
                    print("Decoding failed")// local message
                }
                
            } catch {
                print(error) // shows error
                print("Unable to read file")// local message
            }
        }
    }
    
    func getRandomQuote(completionHandler: @escaping (Quote) -> Void)
    {
        if let path = Bundle.main.path(forResource: "Quotes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                do {
                    
                    let ApiModel = try decoder.decode(ApiResponse.self, from: data)
                                
                    completionHandler((ApiModel.quotes?.randomElement())!)
                    
                    
                }catch{
                    print(error) // shows error
                    print("Decoding failed")// local message
                }
                
            } catch {
                print(error) // shows error
                print("Unable to read file")// local message
            }
        }
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

