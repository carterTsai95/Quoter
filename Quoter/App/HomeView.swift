//
//  HomeView.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-18.
//

import SwiftUI

struct HomeView: View {
    
    
    @ObservedObject var favorites = Favorites()
    
    var body: some View {
        TabView {
            HomeQuoteScreen().tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            CategoryGridView().tabItem {
                Image(systemName: "list.bullet.indent")
                Text("Categories")
            }
            UsersFavorites().tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }
            SettingsView().tabItem {
                Image(systemName: "ellipsis")
                Text("More")
            }
        }
        .environmentObject(favorites)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Favorites())
    }
}
