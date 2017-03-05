//
//  Helpers.swift
//  Proyecto1
//
//  Created by Hsing-Li on 2/25/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import Foundation
import UIKit

class Helpers {
    public static func getRGBAs(fromImage image: UIImage, x: Int, y: Int) -> PixelInfo {
        
        let result = PixelInfo()
        
        // First get the image into your data buffer
        guard let cgImage = image.cgImage else {
            print("CGContext creation failed")
            return result
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let rawdata = calloc(height*width*4, MemoryLayout<CUnsignedChar>.size)
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        
        guard let context = CGContext(data: rawdata, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
            print("CGContext creation failed")
            return result
        }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // Now your rawData contains the image data in the RGBA8888 pixel format.
        var byteIndex = bytesPerRow * y + bytesPerPixel * x
        
        for _ in 0 ..< 1 {
            let alpha = CGFloat(rawdata!.load(fromByteOffset: byteIndex + 3, as: UInt8.self)) / 255.0
            let red = CGFloat(rawdata!.load(fromByteOffset: byteIndex, as: UInt8.self)) / alpha
            let green = CGFloat(rawdata!.load(fromByteOffset: byteIndex + 1, as: UInt8.self)) / alpha
            let blue = CGFloat(rawdata!.load(fromByteOffset: byteIndex + 2, as: UInt8.self)) / alpha
            byteIndex += bytesPerPixel
            
            //let aColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            
            result.blue = Int(blue)
            result.red = Int(red)
            result.green = Int(green)
            result.x = x
            result.y = y

        }
        free(rawdata)
        
        return result
    }
    
    public static func discretizeColor(red: Int, green: Int, blue: Int) -> String {
        if(red < 128 && green < 128 && blue < 128) {
            return "black"
        }else if(red >= 128 && green >= 128 && blue >= 128) {
            return "white"
        }else if(red < 128 && green >= 180 && blue < 128) {
            return "green"
        }else if(red >= 180 && green < 128 && blue < 128) {
            return "red"
        }
        return "black"
    }
}
