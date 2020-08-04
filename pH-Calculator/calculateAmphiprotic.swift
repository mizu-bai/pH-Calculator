//
//  calculateAmphiprotic.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/7/14.
//

import Foundation

func calculateAmphiprotic(acidBase: Int, polyprotic: Int, KValue: [Double], cValue: Double) -> Double {
    
    // This function will calculate convert the concentration of proton (H+) or hydroxide (OH-) and then convert it to the pH value according to the parameter of the suolution. It only supports amphiprotic solution: amphiprotic salt, salt formed by weak acid and weak base, and amino acid;

    var cxValue: Double = 0.0 // The concentration of proton (H+) or hydroxide (OH-) calcuted by KValue and cValue.
    var pHValue: Double = 0.0 // The value of pH calcuted by cxValue and the type of the solution.
    let KwValue: Double = 1e-14 // The ionization constant of water.
    
    // Prepare the inputs for Struct CalculateTemp.
    
    var inputDegree: Int = 0
    var inputCoefficient: [Double] = [Double]()
    var inputInitialValue: Double = 0.0
    
    if(polyprotic != 1) {
        
//        print("UNSUPPORT SOLUTION TYPE!")
        
    }
    
    if(acidBase != 3) {

//        print("UNSUPPORT SOLUTION TYPE!")
        
    }
    
    inputDegree = 4
    inputCoefficient = [1, 1 + KValue[0], KValue[0] * KValue[1] - KwValue, -(KValue[0] * KValue[1] + KValue[0] * KwValue), -KValue[0] * KValue[1] * KwValue]
    inputInitialValue = cValue
    
    let ExactEquation = EquationParameter()
    ExactEquation!.initParameter(withDegree: Int32(inputDegree), coefficient: &inputCoefficient, initialValue: inputInitialValue)
    cxValue = ExactEquation!.calculateAndReturnAns()
    
    pHValue = -log10(cxValue)
    
    return pHValue
    
}
