//
//  Constant.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-16.
//

import SwiftUI

// LAYOUT

let columnSpacing: CGFloat = 10
let rowSpacing: CGFloat = 5
var gridLayout: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
}
let testQuote = Quote(text: "Today is the tomorrow we worried about yesterday.", author: "Anonymous", tag: "general", favorite: false)
