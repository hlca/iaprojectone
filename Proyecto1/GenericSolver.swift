//
//  GenericSolver.swift
//  Proyecto1
//
//  Created by Hsing-Li on 3/4/17.
//  Copyright © 2017 Hsing-Li. All rights reserved.
//

import Foundation


class GenericSolver{
    var initialState: Pixel = Pixel()
    var labrinthMatrix: [[String]] = [[String]]()
    
    init(initialState: Pixel, matrix: [[String]]) {
        self.initialState = initialState
        self.labrinthMatrix = matrix
    }
    
    func actions (state: Pixel) -> [String] {
        var availableActions: [String] = []
        
        if(state.X - 1 > 0) {
            //Se puede mover para la izquierda
            if(labrinthMatrix[state.Y][state.X - 1] != "black") {
                //No es pared
                availableActions.append("left")
            }
        }
        if(state.Y - 1 > 0) {
            //Se puede mover hacia arriba
            if(labrinthMatrix[state.Y - 1][state.X] != "black") {
                //No es pared
                availableActions.append("top")
            }
        }
        if(state.X + 1 < labrinthMatrix[0].count) {
            //Se puede mover hacia la derecha
            if(labrinthMatrix[state.Y][state.X + 1] != "black") {
                //No es pared
                availableActions.append("right")
            }
        }
        if(state.Y + 1 < labrinthMatrix.count) {
            //Se puede mover hacia abajo
            //Se puede mover hacia arriba
            if(labrinthMatrix[state.Y + 1][state.X] != "black") {
                //No es pared
                availableActions.append("bottom")
            }
        }
        return availableActions
    }
    
    func result (state: Pixel, action: String) -> Pixel {
        var newState: Pixel = state
        if action == "top" {
            newState.Y = state.Y - 1
        }else if action == "right" {
            newState.X = state.X + 1
        }else if action == "left" {
            newState.X = state.X - 1
        }else if action == "bottom" {
            newState.Y = state.Y + 1
        }
        return newState
    }
    
    func goalTest (state: Pixel) -> Bool {
        return labrinthMatrix[state.Y][state.X] == "green"
    }
    
    func stepCost (state: Pixel, action: String, newState: Pixel) -> Double {
        return 1
    }
    
    func pathCost (states: [Pixel], actions: [String]) -> Double {
        return Double(states.count) - 1
    }
}
