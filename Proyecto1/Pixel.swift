//
//  Pixel.swift
//  Proyecto1
//
//  Created by Hsing-Li on 3/4/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import Foundation
struct Pixel {
    private var _x: Int = -1
    private var _y: Int = -1
    
    var X: Int {
        get {
            return _x
        }
        set {
            _x = newValue
        }
    }
    
    var Y: Int {
        get {
            return _y
        }
        set {
            _y = newValue
        }
    }
    
    func equals(other: Pixel) -> Bool {
        if(_x == other.X) {
            if(_y == other.Y) {
                return true
            }
        }
        return false
    }
}
