//
//  SwiftUIView.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-05-02.
//

import SwiftUI
import SwiftUIPager

struct HomeQuoteScreen: View {
    @StateObject var page: Page = .first()
    @EnvironmentObject var favorites: Favorites
    
    @State var items = [Quote]()
    
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
                                    if self.favorites.contains(quote) {
                                        self.favorites.remove(quote)
                                    } else {
                                        print("add")
                                        self.favorites.add(quote)
                                        
                                    }
                                }) {
                                    if self.favorites.contains(quote) {
                                        Image(systemName: "heart.fill")
                                    } else {
                                        Image(systemName: "heart")
                                    }
                                }
                                .foregroundColor(.red)
                                Button(action: {
                                    //presentingSheet.toggle()
                                }) {
                                    Image(systemName: "square.and.arrow.up")
                                }
                                
                                
                            }
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
