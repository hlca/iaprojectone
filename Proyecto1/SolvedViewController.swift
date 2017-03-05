//
//  SolvedViewController.swift
//  Proyecto1
//
//  Created by Hsing-Li on 3/4/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import UIKit

class SolvedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate   {
    let reuseIdentifier = "solvedCell"
    
    var solvedArray: [String] = []
    var squaresWidth: Double = 0
    var squaresHeight: Double = 0

    @IBOutlet weak var solvedCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        solvedCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        flowLayout.itemSize.height = CGFloat(squaresHeight - 0.01)
        flowLayout.itemSize.width = CGFloat(squaresWidth - 0.01)
        solvedCollectionView.reloadData()
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.solvedArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath)
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.myLabel.text = self.items[indexPath.item]
        if(solvedArray[indexPath.item] == "white") {
            cell.backgroundColor = UIColor.white
        }else if (solvedArray[indexPath.item] == "red") {
            cell.backgroundColor = UIColor.red
        }else if (solvedArray[indexPath.item] == "green") {
            cell.backgroundColor = UIColor.green
        }else if (solvedArray[indexPath.item] == "black") {
            cell.backgroundColor = UIColor.black
        }else {
            cell.backgroundColor = UIColor.purple
        }
        
        cell.frame.size.height = CGFloat(squaresHeight)
        cell.frame.size.width = CGFloat(squaresWidth)
        
        return cell
    }
    
}
