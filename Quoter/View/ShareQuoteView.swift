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
    @State var quote : Quote
    
    var textView: some View {
        
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
                HStack(alignment: .center) {
                    Text(quote.text ?? "None")
                        .font(.callout)
                        .frame(width: 300)
                }
            }
        }
        .padding()
        
    }
    
    var body: some View {
        NavigationView{
            VStack{
                textView
                
                Button("Save to image") {
                    let image = textView.snapshot()
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
                Spacer()
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
}

struct ShareQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        ShareQuoteView(quote: UserQuotes[0])
    }
}
