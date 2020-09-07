//
//  calculateSingle.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/6/30.
//

import Foundation

func calculateSingle(acidBase: Int, polyprotic: Int, KValue: [Double], cValue: Double) -> Double {
    
    // This function will calculate convert the concentration of proton (H+) or hydroxide (OH-) and then convert it to the pH value according to the parameter of the suolution. It only supports monoprotic, diprotic, triprotic, and tetraprotic acid or base.
    // NOTE: Tetraprotic acid or base will be regarded as triprotic acid or base.
    
    var cxValue: Double = 0.0 // The concentration of proton (H+) or hydroxide (OH-) calcuted by KValue and cValue.
    var pHValue: Double = 0.0 // The value of pH calcuted by cxValue and the type of the solution.
    let KwValue: Double = 1e-14 // The ionization constant of water.
    
    // Prepare the inputs for Struct CalculateTemp.
    
    var inputDegree: Int           = 0
    var inputCoefficient: [Double] = [Double]()
    var inputInitialValue: Double  = 0.0

    if(polyprotic == 1) {
        
        // Monoprotic acid or base.
        // cx ^ 3 + K * cx ^ 2 - (K * c + Kw) * cx - K * Kw = 0
        
        inputDegree       = polyprotic + 2
        inputCoefficient  = [1, KValue[0], (-KValue[0] * cValue + KwValue), -(KValue[0] * KwValue)]
        inputInitialValue = cValue
        
    } else if(polyprotic == 2) {
        
        // Diprotic acid or base.
        // cx ^ 4 + K1 * cx ^ 3 + (K1 * K2 - K1 * c - Kw) * cx ^ 2 - (K1 * Kw + 2 * K1 * K2 * c) * cx - K1 * K2 * Kw = 0
        
        inputDegree       = polyprotic + 2
        inputCoefficient  = [1, KValue[0], (KValue[0] * KValue[1] - KValue[0] * cValue - KwValue), -(KValue[0] * KwValue + 2 * KValue[0] * KValue[1] * cValue), -(KValue[0] * KValue[1] * KwValue)]
        inputInitialValue = cValue
        
    } else if(polyprotic >= 3) {
        
        // Triprotic or tetraprotic acid or base.
        // NOTE: Tetraprotic acid or base will be regarded as triprotic acid or base.
        // cx ^ 5 + K1 * cx ^ 4 + (K1 * K2 - K1 * c - Kw) * cx ^ 3 + (K1 * K2 * K3 - 2 * K1 * K2 - K1 * Kw) * cx ^ 2 - (3 * K1 * K2 * K3 + K1 * K2 * Kw) * cx - K1 * K2 * K3 * Kw = 0
        
        inputDegree       = polyprotic + 2
        inputCoefficient  = [1, KValue[0], (KValue[0] * KValue[1] - KValue[0] - KValue[0] * KValue[1] * KValue[2] - 2 * KValue[0] * KValue[1] - KValue[0] * KwValue), -(3 * KValue[0] * KValue[1] * KValue[2] + KValue[0] * KValue[2] * KwValue), -(KValue[0] * KValue[1] * KValue[2])]
        inputInitialValue = cValue
        
        } else {
            
//            print("ERROR EXACT EQUATION!")
        
    }
    
    // In this part, the exact equation about cxValue will be sloved.
        
    let ExactEquation = EquationParameter()
    ExactEquation!.initParameter(withDegree: Int32(inputDegree), coefficient: &inputCoefficient, initialValue: inputInitialValue)
    cxValue = ExactEquation!.calculateAndReturnAns()
    
    // This part will convert the concentration of proton (H+) or hydroxide (OH-) to pH Value.
    
    if(acidBase == 0) {
        
        pHValue = -log10(cxValue)
        
    } else if(acidBase == 1){
        
        pHValue = 14 + log10(cxValue)
        
    } else {
        
//        print("ERROR IN CONVERTING CXVALUE TO PHVALUE!")
        
    }
    
    return pHValue
    
}
