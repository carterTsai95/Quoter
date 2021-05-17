//
//  SwiftUIView.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-05-02.
//

import SwiftUI
import SwiftUIPager
import CoreData

struct HomeQuoteScreen: View {
    @StateObject var page: Page = .first()
    @EnvironmentObject var favorites: Favorites
    @Environment(\.managedObjectContext) var moc
    @State private var presentingSheet = false
    @State var items = [Quote]()
    @State private var selectQuote : Quote? = nil
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Top-2"), Color("Bottom-2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            Pager(page: page,
                  data: items,
                  id: \.self,
                  content: { quote in
                    // create a page based on the data passed
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .opacity(0.001)
                        VStack(spacing: 10){
                            Text("\(quote.text!)")
                                .font(.title)
                                .fontWeight(.ultraLight)
                                .multilineTextAlignment(.center)
                            Text("-\(quote.author!)-")
                                .font(.headline)
                                .fontWeight(.light)

                            
                            HStack(alignment: .bottom,spacing: 20) {
                                Spacer()
                                Button(action: {
                                    // MARK: - TODO
                                    if self.favorites.contains(quote) {
                                        let query = quote.text!
                                        let request: NSFetchRequest<FavoriteQuote> = FavoriteQuote.fetchRequest()
                                        request.predicate = NSPredicate(format: "text == %@", query)
                                        
                                        let objects = try! moc.fetch(request)
                                        for obj in objects {
                                            moc.delete(obj)
                                        }
                                        
                                        do {
                                            try moc.save()
                                        } catch {
                                            // Do something... fatalerror
                                        }
                                        self.favorites.remove(quote)
                                    } else {
                                        
                                        let newFavorite = FavoriteQuote(context: self.moc)
                                        newFavorite.text = quote.text
                                        newFavorite.author = quote.author
                                        newFavorite.tag = quote.tag
                                        try? self.moc.save()
                                        
                                        print("add")
                                        self.favorites.add(quote)
                                        print(quote)
                                    }
                                }) {
                                    if self.favorites.contains(quote) {
                                        Image(systemName: "heart.fill")
                                    } else {
                                        Image(systemName: "heart")
                                    }
                                }
                                .foregroundColor(.red)
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .onTapGesture {
                                        var tempQuote = Quote()
                                        tempQuote.text = quote.text
                                        tempQuote.author = quote.author
                                        self.selectQuote = tempQuote
                                        print(quote.text!)
                                    }
                                .sheet(item: self.$selectQuote) { quote in
                                    ShareQuoteView(quoteText: quote.text!, quoteAuthor: quote.author!)
                                }
                                
                                
                            }// HStack
                            
                            
                        }
                        
                        
                        
                        
                    }
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    
                  })
                .vertical()
                .padding(.all, 30)
                .itemSpacing(5)
                .interactive(rotation: true)
                .interactive(scale: 0.95)
                .sensitivity(.high)
                
                .onPageChanged { newPage in
                    guard newPage > items.count - 2 else { return }
                    getQuote()
                }}
            .environmentObject(favorites)
            .edgesIgnoringSafeArea(.vertical)
            
            .onAppear{
                initQuote()
            }
    }
    
    
    func initQuote(){
        for _ in 1...2 {
            jsonResponse.getRandomQuote{ quote in
                self.items.append(quote)
            }
        }
    }
    
    func getQuote(){
        jsonResponse.getRandomQuote{ quote in
            self.items.append(quote)
            print("Append the new quote")
        }
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeQuoteScreen()
            .environmentObject(Favorites())
    }
}
