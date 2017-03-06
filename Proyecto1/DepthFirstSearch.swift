//
//  DepthFirstSearch.swift
//  Proyecto1
//
//  Created by Hsing-Li on 3/4/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import Foundation


class DepthFirstSearch: GenericSolver {
    func graphSearch() -> [Pixel]{   
        var explored: [Pixel] = []
        var stack: [Pixel] = [initialState]
        
        while true {
            //elección
            var path = stack
            print (stack)
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
            
            //
            var oneAdded = false
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
                    stack = newPath
                    oneAdded = true
                    break;
                }
            }
            if(!oneAdded) {
                stack.remove(at: stack.count - 1)
            }
        }
    }
}
