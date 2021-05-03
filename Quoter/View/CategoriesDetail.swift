//
//  CategoriesDetail.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-18.
//

import SwiftUI




struct CategoriesDetail: View {
    
    let category: Quote.tag
    @State var quotes = [Quote]()
    @ObservedObject var favorites = Favorites()
    
    
    var body: some View {
        
        VStack {
            HStack {
                VStack(spacing: 5) {
                    Image("\(category.rawValue)")
                        .resizable()
                        .frame(width: 150, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(color: Color(UIColor.systemGray5), radius: 5, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color.gray.opacity(0.25)))
                        .padding()
                    
                    Text(category.rawValue.capitalized)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .font(.title)
                        .foregroundColor(Color(UIColor.systemGray))
                    ScrollView() {
                        ForEach(quotes.shuffled().prefix(10), id: \.id){ quote in
                            VStack(alignment: .leading, spacing: 5){
                                QuoteCardView(quote: quote)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 10)
                    }
                    
                    
                    
                }
                .navigationTitle("\(category.rawValue.capitalized)")
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(StackNavigationViewStyle())
                
                
            }
        }
        .onAppear{
            readJson()
        }
        
    }
    
    func readJson(){
        jsonResponse.getQuotesByCategory(category: self.category) { quotes in
            self.quotes = quotes
        }
    }
    
}

struct QuoteCardView: View {
    
    @EnvironmentObject var favorites: Favorites
    @State private var presentingSheet = false
    var quote: Quote
    
    
    var body: some View {
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
                HStack(alignment: .bottom,spacing: 20) {
                    Spacer()
                    Button(action: {
                        if self.favorites.contains(self.quote) {
                            self.favorites.remove(self.quote)
                        } else {
                            print("add")
                            self.favorites.add(self.quote)
                            print(quote)
                        }
                    }) {
                        if self.favorites.contains(self.quote) {
                            Image(systemName: "heart.fill")
                        } else {
                            Image(systemName: "heart")
                        }
                    }
                    .foregroundColor(.red)
                    Button(action: {
                        presentingSheet.toggle()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    
                }
                
                
            }
            .font(.title2)
        }
        .environmentObject(favorites)
        .sheet(isPresented: $presentingSheet) {
            ShareQuoteView(quote: quote)
        }
        
        
        
    }
}


struct CategoriesDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CategoriesDetail(category: Quote.tag.attitude)
                .environmentObject(Favorites())
            
            
            QuoteCardView(quote: testQuote)
                .environmentObject(Favorites())
                .previewLayout(.sizeThatFits)
                .padding()
            
            QuoteCardView(quote: testQuote)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .environmentObject(Favorites())
                .previewLayout(.sizeThatFits)
                
                .padding()
        }
    }
}
