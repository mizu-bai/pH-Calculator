//
//  calculateBuffer.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/7/14.
//

import Foundation

func calculateBuffer(acidBase: [Int], polyprotic: Int, KValue: Double, cValue: [Double]) -> Double {
    
    // This function will calculate convert the concentration of proton (H+) or hydroxide (OH-) and then convert it to the pH value according to the parameter of the suolution. It only supports acid-base buffer solution.
    
    var cxValue: Double = 0.0 // The concentration of proton (H+) or hydroxide (OH-) calcuted by KValue and cValue.
    var pHValue: Double = 0.0 // The value of pH calcuted by cxValue and the type of the solution.
    // let KwValue: Double = 1e-14 // The ionization constant of water.
    
    if(polyprotic != 1) {
        
//        print("UNSUPPORT SOLUTION TYPE!")
        
    }
    
    if(acidBase[0] + acidBase[1] > 1 ) {

//        print("UNSUPPORT SOLUTION TYPE!")
        
    }
    
    var cacidValue: Double = 0.0
    var cconjugateBase: Double = 0.0
    
    for index in acidBase {
        
        if(acidBase[index] == 0) {
            
            cacidValue = cValue[index]
            
        } else if(acidBase[index] == 1) {
            
            cconjugateBase = cValue[index]
            
        }
    }
    
    cxValue = KValue * cacidValue / cconjugateBase
        
    pHValue = -log10(cxValue)
    
    return pHValue
    
}
