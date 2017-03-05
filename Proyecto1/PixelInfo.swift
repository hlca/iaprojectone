//
//  PixelInfo.swift
//  Proyecto1
//
//  Created by Hsing-Li on 2/25/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import Foundation


class PixelInfo {
    private var _x: Int = -1
    private var _y: Int = -1
    
    private var _red: Int = -1
    private var _blue: Int = -1
    private var _green: Int = -1
    
    var x: Int {
        get {
            return _x
        }
        set(newX) {
            _x = newX
        }
    }
    
    var y: Int {
        get {
            return _y
        }
        set(newY) {
            _y = newY
        }
    }
    
    var red: Int {
        get {
            return _red
        }
        set(newRed) {
            _red = newRed
        }
    }
    var blue: Int {
        get {
            return _blue
        }
        set(newBlue) {
            _blue = newBlue
        }
    }
    var green: Int {
        get {
            return _green
        }
        set(newGreen) {
            _green = newGreen
        }
    }
}
