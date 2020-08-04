//
//  calculateMixed.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/7/14.
//

import Foundation

func calculateMixed(acidBase: [Int], polyprotic: [Int], KValue: [Double], cValue: [Double]) -> Double {
    
    // This function will calculate convert the concentration of proton (H+) or hydroxide (OH-) and then convert it to the pH value according to the parameter of the suolution. It only supports acid & acid, base & base, and acid & base, which are all monoprotic.

    var cxValue: Double = 0.0 // The concentration of proton (H+) or hydroxide (OH-) calcuted by KValue and cValue.
    var pHValue: Double = 0.0 // The value of pH calcuted by cxValue and the type of the solution.
    let KwValue: Double = 1e-14 // The ionization constant of water.
    
    // Prepare the inputs for Struct CalculateTemp.
    
    var inputDegree: Int = 0
    var inputCoefficient: [Double] = [Double]()
    var inputInitialValue: Double = 0.0
    
    if(polyprotic != [1, 1]) {
        
//        print("UNSUPPORT SOLUTION TYPE!")
        
    }
    
    if(acidBase[0] + acidBase[1] > 2 ) {

//        print("UNSUPPORT SOLUTION TYPE!")
        
    }
    
    if(acidBase[0] == acidBase[1]) {
        
        // Acid & acid or base & base.
        // cx ^ 4 + (KA + KB) * cx ^ 3 + (KA * KB - KA * cA - KB * cB - Kw) * cx ^ 2 - (KA * KB * (cA + cB) + Kw * (KA + KB)) * cx - KA * KB * Kw = 0
        
//        cxValue = solveEquation(maxIndex: 4, coefficient: [1, KValue[0] + KValue[1], KValue[0] * KValue[1] - KValue[0] * cValue[0] - KValue[1] * cValue[1] - KwValue, -(KValue[0] * KValue[1] * (cValue[0] + cValue[1]) + KwValue * (KValue[0] + KValue[1])), -KValue[0] * KValue[1] * KwValue], initialValue: (cValue[0] + cValue[1]) / 2)
        
        inputDegree = 4
        inputCoefficient = [1, KValue[0] + KValue[1], KValue[0] * KValue[1] - KValue[0] * cValue[0] - KValue[1] * cValue[1] - KwValue, -(KValue[0] * KValue[1] * (cValue[0] + cValue[1]) + KwValue * (KValue[0] + KValue[1])), -KValue[0] * KValue[1] * KwValue]
        inputInitialValue = (cValue[0] + cValue[1]) / 2
        
    } else if(acidBase[0] + acidBase[1] == 1) {
        
        // Acid & base.
        
        var KaValue: Double = 0.0
        var KbValue: Double = 0.0
        var caValue: Double = 0.0
        var cbValue: Double = 0.0
        
        for index in acidBase {

            if(index == 0) {

                KaValue = KValue[index]
                caValue = cValue[index]

            } else if(index == 1) {

                KbValue = KValue[index]
                cbValue = cValue[index]

            }
        }
            
        // Kb * cx ^ 4 + (Ka * Kb + Kw + Kb * cb) * cx ^ 3 + ((Ka - Kb) * Kw + Ka * Kb * (cb - ca)) * cx ^ 2 - (Ka * Kb * Kw + Kw * Ka * ca + Kw ^ 2) * cx - Kw ^ 2 * Ka = 0
        
        inputDegree = 4
        inputCoefficient = [KbValue, KaValue * KbValue + KwValue + KbValue * cbValue, (KaValue - KbValue) * KwValue + KaValue * KbValue * (cbValue - caValue), -(KaValue * KbValue * KwValue + KwValue * KaValue * caValue + pow(KwValue, 2)), -(pow(KwValue, 2) * KaValue)]
        inputInitialValue = (cValue[0] + cValue[1]) / 2
                
    } else {
        
//        print("ERROR IN SOLVING THE EXACT EQUATION!")
        
    }
    
    let ExactEquation = EquationParameter()
    ExactEquation!.initParameter(withDegree: Int32(inputDegree), coefficient: &inputCoefficient, initialValue: inputInitialValue)
    cxValue = ExactEquation!.calculateAndReturnAns()
    
    if((acidBase == [0, 0]) || (acidBase[0] + acidBase[1] == 1)) {
        
        pHValue = -log10(cxValue)
        
    } else if(acidBase == [1, 1]) {
        
        pHValue = 14 + log10(cxValue)
                
    } else {
        
//        print("ERROR IN CONVERTING CXVALUE TO PHVALUE!")
        
    }
    
    return pHValue
    
}
