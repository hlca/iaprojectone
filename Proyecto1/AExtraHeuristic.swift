//
//  ADistanceHeuristic.swift
//  Proyecto1
//
//  Created by Hsing-Li on 3/4/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import Foundation

class AExtraHeuristic: GenericSolver {
    var explored: [Pixel] = []
    var selectedFinal: Pixel = Pixel()
    
    func graphSearch(finals: [Pixel]) -> [Pixel] {
        var stack: [Pixel] = [initialState]
        
        for f in finals {
            if(selectedFinal.equals(other: Pixel())) {
                selectedFinal = f
            }
            else {
                let selectedFinalDistance: Double = heuristic(state: initialState, f: selectedFinal)
                let actualDistance: Double = heuristic(state: initialState, f: f)
                if(actualDistance < selectedFinalDistance) {
                    selectedFinal = f
                }
            }
        }
        //Ahora ya sabemos a qué "meta" vamos a llegar
        while true {
            //elección
            var path = stack
            //print (stack)
            //tomamos el último elemento
            let s = path[path.count - 1]
            explored.append(s)
            
            //test
            if goalTest(state: s) {
                print(path)
                return path
            }
            print(path)
            //Expansion
            let myActions = actions(state: s)
            
            //Tengo las acciones posibles a realizar desde el nodo actual
            var defaultHeuristic = ["top": 1000.0, "right": 1000.0, "bottom": 1000.0, "left": 1000.0]
            for action in myActions {
                let testState = result(state: s, action: action)
                //acá se calcula la eurística
                defaultHeuristic[action] = heuristic(state: testState, f: selectedFinal) + stepCost(state: s, action: action, newState: testState)
                for thisExplored in explored {
                    if(thisExplored.equals(other: testState)) {
                        defaultHeuristic[action] = 1000.0
                    }
                }
            }
            
            var selectedAction: String = String()
            var selectedDistance = 1000.1
            for (action, distance) in defaultHeuristic {
                if(distance < selectedDistance) {
                    selectedAction = action
                    selectedDistance = distance
                }
            }
            var oneAdded = false
            
            let myResult = result(state: s, action: selectedAction)
            
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
            }
            
            if(!oneAdded) {
                stack.remove(at: stack.count - 1)
            }
        }
    }
    
    func heuristic(state: Pixel, f: Pixel) -> Double {
        let distance =  abs(Int32(f.X - state.X)) + abs(Int32(f.Y - state.Y))
        return Double(distance)
    }
}
