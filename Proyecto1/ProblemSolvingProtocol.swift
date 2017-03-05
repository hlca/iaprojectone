//
//  ProblemSolvingProtocol.swift
//  Proyecto1
//
//  Created by Hsing-Li on 3/4/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

protocol ProblemSolvingProtocol {
    var initialState: Pixel { get set }
    static func actions (state: Pixel) -> [String]
    static func result (state: Pixel, action: String) -> Pixel
    static func goalTest (state: Pixel) -> Bool
    static func stepCost (state: Pixel, action: String, newState: Pixel) -> Double
    static func pathCost (states: [Pixel], actions: [String]) -> Double
}
