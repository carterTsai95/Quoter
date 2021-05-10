//
//  ShareQuoteView.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-28.
//

import SwiftUI

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

struct ShareQuoteView: View {
    @Environment(\.presentationMode) var presentation
    @State var quoteText : String
    @State var quoteAuthor : String
    
    var textView: some View {
        
        Group{
            VStack(spacing: 10){
                Text("\(quoteText)")
                    .font(.title)
                    .fontWeight(.ultraLight)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("-\(quoteAuthor)-")
                    .font(.title2)
                    .fontWeight(.light)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("Top"), Color("Bottom")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea(edges: .top))
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                textView
                    .overlay(bottombar, alignment: .bottom)

            }//: VStack
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Share")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: { presentation.wrappedValue.dismiss() })
                }
            }
        }
    }
    
    var bottombar: some View {
        VStack {
            Button(action: {
        
                let image = textView
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .snapshot()
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                
            }) {
                Text("Save to Album")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding()
                    .frame(width: 300)
                    .background(Color.init(.systemIndigo))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
    }
}

struct ShareQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        ShareQuoteView(quoteText: UserQuotes[0].text!, quoteAuthor: UserQuotes[0].author!)
    }
}
