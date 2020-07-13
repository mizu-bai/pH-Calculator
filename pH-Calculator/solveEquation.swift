//
//  solveEquation.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/7/14.
//

import Foundation

func solveEquation(maxIndex: Int, coefficient: [Double], initialValue: Double) -> Double {
    
    // Newton method for solving equation of higher power with one unknown quantity.
    
    /*
     
     Example equation
     
        a * x ^ 2 + b * x + c = 0
        maxIndex = 2
        coefficient = [a, b, c]
        primitiveFunctionIndexArray = [2, 1, 0]
        derivativeFunctionIndexArray = [1, 0]
     
     ReWrote primitive function and derivate function
     
        y = coefficient[0] * pow(x, primitiveFunctionIndexArray[0]) + coefficient[1] * pow(x, primitiveFunctionIndexArray[1]) + coefficient[2] * pow(x, primitiveFunctionIndexArray[2])
        dy = coefficient[0] * (derivativeFunctionIndexArray[0] + 1) * pow(x, derivativeFunctionIndexArray[0]) + coefficient[1] * (derivativeFunctionIndexArray[1] + 1) * pow(x, derivateFunctionIndexArray[1])
     
     */
    
    var primitiveFunctionIndexArray: [Int] = []
    var derivativeFunctionIndexArray: [Int] = []
    var x: Double = initialValue
    var x0: Double
    var y: Double
    var dy: Double
    
    for index in stride(from: maxIndex, through: 0, by: -1) {
        
        primitiveFunctionIndexArray.append(index)
        
    }
    
    for index in stride(from: (maxIndex - 1), through: 0, by: -1) {
        
        derivativeFunctionIndexArray.append(index)
        
    }
    
    repeat {
        
        x0 = x
        y = 0.0
        dy = 0.0
        
        for index in primitiveFunctionIndexArray {
            
            y += coefficient[index] * pow(x0, Double(primitiveFunctionIndexArray[index]))
            
        }
        
        for index in derivativeFunctionIndexArray {
            
            dy += coefficient[index] * Double(derivativeFunctionIndexArray[index] + 1) * pow(x0, Double(derivativeFunctionIndexArray[index]))
            
        }
        
        x = x0 - y / dy
        
    } while(fabs(x - x0) >= 1e-5)
    
    return x
    
}
