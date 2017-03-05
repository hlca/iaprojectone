//
//  ViewController.swift
//  Proyecto1
//
//  Created by Hsing-Li on 2/24/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var imagePicker: UIImagePickerController!
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
   

    @IBOutlet weak var discretizeBtn: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txDiscretize: UITextField!
    @IBAction func takePhoto(_ sender: Any) {
        imagePicker.delegate =  self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    var DataMatrix: [[String]] = [[""]]
    var widthStep: Double = 0
    var heightStep: Double = 0
    var image: UIImage = UIImage()
    
    func imagePickerController(
        _ picker:                           UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any])
    {
        imagePicker.dismiss(animated: true, completion: nil)
        image = (info[UIImagePickerControllerEditedImage] as? UIImage!)!
        imageView.image = image
    }
    
    func discretize(width: Int, height: Int, image: UIImage) {
        let discretizeSize = Int(txDiscretize.text!)!
        widthStep = Double(width)/Double(discretizeSize)
        heightStep = Double(height)/Double(discretizeSize)
        
        var arr = Array(repeating: Array(repeating: "black", count: discretizeSize), count: discretizeSize)
        //let discretizeSizeHalf = Int(discretizeSize / 2);
        for j in 0 ..< Int(discretizeSize) {
            let leftX: Int = j * Int(widthStep) + Int(widthStep/4)
            let centerX: Int = j * Int(widthStep) + Int(widthStep/2)
            let rightX: Int = j * Int(widthStep) + Int((3 * widthStep)/4)
            
            for i in 0 ..< Int(discretizeSize) {
                let topY: Int = i * Int(heightStep) + Int(heightStep/4)
                let centerY: Int = i * Int(heightStep) + Int(heightStep/2)
                let bottomY: Int = i * Int(heightStep) + Int(3 * (heightStep)/4)
                
                let TopLeftPixel: PixelInfo = Helpers.getRGBAs(fromImage: image, x: leftX, y: topY)
                let TopRightPixel: PixelInfo = Helpers.getRGBAs(fromImage: image, x: rightX, y: topY)
                let CenterPixel: PixelInfo = Helpers.getRGBAs(fromImage: image, x: centerX, y: centerY)
                let BottomLeftPixel: PixelInfo = Helpers.getRGBAs(fromImage: image, x: leftX, y: bottomY)
                let BottomRightPixel: PixelInfo = Helpers.getRGBAs(fromImage: image, x: rightX, y: bottomY)
                
//                let TopPixel: PixelInfo = Helpers.getRGBAs(fromImage: image, x: topX, y: topY)
//                let MidPixel: PixelInfo = Helpers.getRGBAs(fromImage: image, x: leftX, y: centerY)
                
                
                let colorTopRight = Helpers.discretizeColor(red: TopRightPixel.red, green: TopRightPixel.green, blue: TopRightPixel.blue)
                let colorTopLeft = Helpers.discretizeColor(red: TopLeftPixel.red, green: TopLeftPixel.green, blue: TopLeftPixel.blue)
                let colorCenter = Helpers.discretizeColor(red: CenterPixel.red, green: CenterPixel.green, blue: CenterPixel.blue)
                let colorBottomLeft = Helpers.discretizeColor(red: BottomLeftPixel.red, green: BottomLeftPixel.green, blue: BottomLeftPixel.blue)
                let colorBottomRight = Helpers.discretizeColor(red: BottomRightPixel.red, green: BottomRightPixel.green, blue: BottomRightPixel.blue)
                var color: String = ""
                
                if(colorCenter == "green" || colorTopRight == "green" || colorTopLeft == "green" || colorBottomRight == "green" || colorBottomLeft == "green") {
                    color = "green"
                }else if(colorCenter == "red" || colorTopRight == "red" || colorTopLeft == "red" || colorBottomRight == "red" || colorBottomLeft == "red") {
                    color = "red"
                }else {
                    var selectedColor = ["white": 0, "black": 0]
                    
                    selectedColor[colorCenter]! += 1
                    selectedColor[colorTopRight]! += 1
                    selectedColor[colorTopLeft]! += 1
                    selectedColor[colorBottomRight]! += 1
                    selectedColor[colorBottomLeft]! += 1
                    
                    if(selectedColor["white"]! > selectedColor["black"]!) {
                        color = "white"
                    }else {
                        color = "black"
                    }
                    
                }
                
                //print(color)
                arr[i][j] = color
            }
        }
        
        //print(widthStep)
        //collectionView.sizeToFit()
        
        //collectionView.insertItems(at: IndexPath(row: 1, section: 1))
//        let pixel: PixelInfo = Helpers.getRGBAs(fromImage: image!, x: 0, y: 0)
//        print(pixel.red)
        DataMatrix = arr;
        //print (arr)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDiscretizeSegue" {
            if let destination = segue.destination as? DiscretizeViewController {
                let height = Int(image.size.height)
                let width = Int(image.size.width)
                discretize(width: width, height: height, image: image)
                destination.squaresWidth = 15//widthStep/2.13333333333
                destination.squaresHeight = 15//heightStep/2.13333333333
                destination.squaresInfo = [["white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white"], ["black", "black", "black", "black", "white", "white", "white", "black", "black", "black", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white"], ["black", "black", "black", "black", "white", "white", "white", "black", "black", "black", "white", "white", "black", "black", "white", "white", "white", "white", "white", "white"], ["black", "black", "black", "black", "white", "white", "white", "white", "white", "white", "white", "white", "black", "black", "white", "white", "green", "white", "white", "white"], ["black", "black", "black", "black", "black", "white", "white", "white", "white", "white", "white", "white", "black", "black", "white", "white", "white", "white", "black", "black"], ["black", "black", "white", "black", "black", "black", "white", "white", "white", "white", "white", "black", "black", "black", "white", "white", "white", "black", "black", "black"], ["black", "white", "white", "white", "black", "black", "white", "white", "white", "white", "white", "black", "black", "black", "white", "white", "white", "white", "white", "white"], ["white", "white", "green", "white", "white", "white", "white", "white", "black", "black", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white"], ["white", "white", "green", "white", "black", "white", "white", "white", "black", "black", "black", "white", "white", "white", "white", "white", "white", "white", "white", "white"], ["black", "black", "white", "white", "black", "black", "white", "white", "black", "black", "black", "black", "white", "white", "white", "white", "white", "white", "white", "white"], ["white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "black", "black", "white", "black", "black", "black", "black", "black", "white", "white"], ["black", "black", "white", "white", "white", "white", "black", "black", "white", "white", "white", "white", "white", "black", "black", "black", "black", "black", "white", "white"], ["black", "black", "black", "black", "black", "white", "black", "black", "black", "white", "white", "white", "black", "black", "black", "black", "black", "black", "white", "white"], ["white", "white", "black", "black", "black", "white", "black", "black", "black", "white", "white", "white", "white", "white", "white", "white", "black", "black", "black", "black"], ["white", "white", "black", "black", "black", "black", "black", "black", "black", "white", "white", "black", "black", "white", "white", "white", "black", "black", "black", "black"], ["white", "white", "black", "black", "black", "black", "black", "black", "black", "white", "white", "black", "black", "white", "white", "white", "black", "black", "black", "black"], ["black", "black", "black", "black", "black", "black", "black", "black", "black", "white", "white", "white", "white", "white", "white", "red", "black", "black", "black", "black"], ["black", "black", "black", "black", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "white", "black", "black", "black", "black"], ["black", "black", "black", "black", "white", "white", "white", "white", "white", "black", "black", "black", "white", "white", "white", "white", "black", "black", "black", "black"], ["black", "black", "white", "white", "white", "white", "white", "white", "white", "black", "black", "black", "white", "white", "white", "white", "black", "black", "black", "black"]]
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

