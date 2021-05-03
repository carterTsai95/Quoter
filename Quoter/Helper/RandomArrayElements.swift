//
//  RandomArrayElements.swift
//  Quoter
//
//  Created by Hung-Chun Tsai on 2021-04-30.
//

import Foundation

extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
