//
//  DiscretizeViewController.swift
//  Proyecto1
//
//  Created by Hsing-Li on 3/4/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import UIKit

class DiscretizeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    let reuseIdentifier = "cell"
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"]

    var Test: String = ""
    var squaresWidth: Double = 0
    var squaresHeight: Double = 0
    var squaresInfo: [[String]] = [[""]]
    var squaresArray: [String] = Array()
    var red: Pixel = Pixel()
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var collecitonView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        flowLayout.itemSize.height = CGFloat(squaresHeight - 0.01)
        flowLayout.itemSize.width = CGFloat(squaresWidth - 0.01)
        fillArrayOfValues(matrix: squaresInfo)
        collecitonView.reloadData()
    }
    
    
    func fillArrayOfValues(matrix: [[String]]) {
        squaresArray = []
        var y = 0
        var x = 0
        for row in matrix {
            x = 0
            squaresArray += row
            if(red.equals(other: Pixel())) {
                for item in row {
                    if(item == "red") {
                        red.X = x
                        red.Y = y
                    }
                    x += 1
                }
            }
            y += 1
            
        }
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.squaresArray.count
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 3)/20, height: 300)
    }
    
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath)
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.myLabel.text = self.items[indexPath.item]
        if(self.squaresArray[indexPath.item] == "white") {
            cell.backgroundColor = UIColor.white
        }else if (self.squaresArray[indexPath.item] == "red") {
            cell.backgroundColor = UIColor.red
        }else if (self.squaresArray[indexPath.item] == "green") {
            cell.backgroundColor = UIColor.green
        }else if (self.squaresArray[indexPath.item] == "solution") {
            cell.backgroundColor = UIColor.white
        }else {
            cell.backgroundColor = UIColor.black
        }
        
        cell.frame.size.height = CGFloat(squaresHeight)
        cell.frame.size.width = CGFloat(squaresWidth)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
    }
    
    
    @IBAction func SolveBtn(_ sender: Any) {
        collecitonView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSolutionSegue" {
            if let destination = segue.destination as? SolvedViewController {
                let solver: DepthFirstSearch = DepthFirstSearch(initialState: red, matrix: squaresInfo)
                let pathItems = solver.graphSearch()
                for pathItem in pathItems {
                    if(!(squaresInfo[pathItem.Y][pathItem.X] == "red" || squaresInfo[pathItem.Y][pathItem.X] == "green")) {
                        squaresInfo[pathItem.Y][pathItem.X] = "solution"
                    }
                }
                fillArrayOfValues(matrix: squaresInfo)

                destination.solvedArray = self.squaresArray
                destination.squaresHeight = self.squaresHeight
                destination.squaresWidth = self.squaresWidth
                
                
            }
        }
    }

}
