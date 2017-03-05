//
//  BreadthSearchFirst.swift
//  Proyecto1
//
//  Created by Hsing-Li on 3/4/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import Foundation

class BreadthSearchFirst: GenericSolver {

    func graphSearch() -> [Pixel]{
        var frontier = [[initialState]]
        var explored = [Pixel]()
        
        while true {
            //elección
            var path = frontier.remove(at: 0)
            //tomamos el último elemento
            let s = path[path.count - 1]
            explored.append(s)
            
            //test
            if goalTest(state: s) {
                print(path)
                return path
            }
            
            //Expansion
            let myActions = actions(state: s)
            for action in myActions {
                let myResult = result(state: s, action: action)
                var isExplored = false
                for thisExplored in explored {
                    if(thisExplored.equals(other: myResult)) {
                        isExplored = true
                    }
                }
                if(!isExplored) {
                    var newPath: [Pixel] = path
                    newPath.append(myResult)
                    frontier.append(newPath)
                }
            }
        }
    }
}
