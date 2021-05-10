//
//  CategoriesView.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-16.
//

import SwiftUI

struct ApiResponse: Codable{
    var message: String?
    var quotes: [Quote]?
}



struct CategoryGridView: View {
    var gridItems : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())]
    
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical) {
                
                Divider()
                    .frame(width: 350)
                LazyVGrid(columns: gridItems, spacing: 10) {
                    
                    ForEach(Quote.tag.allCases, id: \.self) { category in
                        
                        CategoryItemView(category: category)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                            
    
                    }
                    
                }
                .padding(.all, 10)
                
                
            }
            .navigationBarTitle("Categories")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(favorites)
    }
    
}


struct CategoryItemView: View {
    
    // MARK: - PROPERTY
    
    let category: Quote.tag
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack(alignment: .leading){
            NavigationLink(destination: CategoriesDetail(category: category)) {
                Image("\(category.rawValue)")
                    .resizable()
                    .frame(width: 170, height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color.gray.opacity(0.25)))
                    .shadow(color: Color(UIColor.systemGray5), radius: 5, y: 4)
            }
            Text(category.rawValue.capitalized)
                .fontWeight(.regular)
                .font(.subheadline)
            
        }
        
        
    }
}



struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CategoryGridView()
                .environmentObject(Favorites())
                .preferredColorScheme(.dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
                .previewDisplayName("iPhone 12")
            CategoryGridView()
                .environmentObject(Favorites())
            
            CategoryItemView(category: Quote.tag.best)
                .previewLayout(.sizeThatFits)
                .padding()
        }
        
    }
}
