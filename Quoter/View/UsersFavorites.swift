//
//  UsersFavorites.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-27.
//

import SwiftUI

struct UsersFavorites: View {
    
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .center, spacing: 5){
                if(favorites.quotes.isEmpty) {
                    
                    Image("emptyPage")
                        .resizable()
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Haven't had favorite")
                        .font(.title2)
                    
                    
                    
                } else {
                    ScrollView {
                        ForEach(Array(favorites.quotes)){ quote in
                            
                            QuoteCardView(quote: quote)
                            
                        }
                    }
                }
                
            }//: VStack
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
            .animation(.easeOut(duration: 0.3))
            
            
            .navigationBarTitle("My Favorite")
            
        }
        .environmentObject(favorites)
        
        
        
    }
}

struct UsersFavorites_Previews: PreviewProvider {
    static var previews: some View {
        UsersFavorites()
            .environmentObject(Favorites())
    }
}
