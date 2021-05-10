//
//  UsersFavorites.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-27.
//

import SwiftUI
import CoreData

struct UsersFavorites: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var presentingSheet = false
    @FetchRequest(entity: FavoriteQuote.entity(), sortDescriptors: []) var favorites: FetchedResults<FavoriteQuote>
    
    @State private var selectQuote : Quote? = nil
    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("Top"), Color("Bottom")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(edges: .top)
                
                
                List{
                    ForEach(favorites, id: \.self){ quote in
                        VStack(alignment: .leading, spacing: 5){
                            GroupBox(
                                label:
                                    HStack {
                                        Spacer()
                                        Text("-\(quote.author ?? "Unkown Author")-" )
                                        Spacer()
                                    }
                            ) {
                                Divider().padding(.vertical, 5)
                                VStack(spacing: 10) {
                                    HStack(alignment: .center, spacing: 10) {
                                        Text(quote.text ?? "None")
                                            .font(.callout)
                                    }
                                    
                                    HStack{
                                        Spacer()
                                        Button(action: {
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
                                                
                                            } else {
                                                let newFavorite = FavoriteQuote(context: self.moc)
                                                newFavorite.text = quote.text
                                                newFavorite.author = quote.author
                                                newFavorite.tag = quote.tag
                                                try? self.moc.save()
                                            }
                                        }, label: {
                                            if favorites.contains(quote) {
                                                Image(systemName: "heart.fill")
                                            } else {
                                                Image(systemName: "heart")
                                            }
                                        }).foregroundColor(.red)
                                        
                                        Image(systemName: "square.and.arrow.up")
                                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                            .onTapGesture {
                                                var tempQuote = Quote()
                                                tempQuote.text = quote.text
                                                tempQuote.author = quote.author
                                                self.selectQuote = tempQuote
                                                print(quote.text!)
                                            }
                                    }
                                    
                                }
                                .font(.title2)
                            }//-: GroupBox
                        }
                        .sheet(item: self.$selectQuote) { quote in
                            ShareQuoteView(quoteText: quote.text!, quoteAuthor: quote.author!)
                        }
                    }
                    .padding(.vertical, 5)
                    
                }//List
                .listStyle(InsetListStyle())
                .navigationBarTitle("My Favorites", displayMode: .large)
                
                
                // MARK: - NO TODO ITEMS
                if favorites.count == 0 {
                    VStack{
                        Image("emptyPage")
                            .resizable()
                            .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("Haven't had favorite")
                            .font(.system(.headline, design: .rounded))
                    }
                    
                }
            }
            
            
            
            
        }
    }
}

struct UsersFavorites_Previews: PreviewProvider {
    static var previews: some View {
        UsersFavorites()
            .environmentObject(Favorites())
    }
}
