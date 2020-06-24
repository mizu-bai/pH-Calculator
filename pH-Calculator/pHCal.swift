//
//  pHCal.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/6/24.
//

import Foundation

struct pHCal {
    
    var acidBase: Int // The type of the solution, acid corresponds to value 0 and base corresponds to value 1.
    var polyproticAcidBase: Int //The number of proton the acid can provide or the base can accept.
    var KpK: Int // The type of selected K or pK, K corresponds to value 0 and pK corresponds to value 1.
    var KpKInputValue: [Double] = [Double]() // The input values of K or pK.
    var KValue: [Double] = [Double]() // The values of K caculated by K or pK type and KpKInputValue.
    var cValue: Double = 0.0 // The input value of solution concentration.
    var cxValue: Double = 0.0 // The concentration of proton (H+) or hydroxide (OH-) calcuted by KValue and cValue.
    var pHValue: Double = 0.0// The value of pH calcuted by cxValue and the type of the solution.
    let KwValue: Double = 1e-14 // The ionization constant of water.
    
    init(fromacidBase acidBase: Int, frompolyproticAcidBase polyproticAcidBase: Int, fromKpK KpK: Int, fromKpKInputValue KpKInputValue: [Double], fromcValue cValue: Double) {
        
        self.acidBase = acidBase
        self.polyproticAcidBase = polyproticAcidBase
        self.KpK = KpK
        self.KpKInputValue = KpKInputValue
        self.cValue = cValue
        
        // This part will deal with the input K or pK Value. If the inputs are Ka or Kb, they will be saved to array KValue. If the inputs are pKa of pKb, they will be converted to Ka or Kb before saved.
        
        if(KpK == 0) {
            
            for i in 0 ..< polyproticAcidBase {
                
                KValue.append(KpKInputValue[i])
                
            }
            
        } else {
            
            for i in 0 ..< polyproticAcidBase {
                
                KValue.append(pow(10, (-KpKInputValue[i])))
                
            }
        }
                
        // This part will convert the concentration of proton (H+) or hydroxide (OH-) to the pH value according to the type of the suolution. It only supports monoprotic, diprotic, and triprotic acid or base.
        
        // Newton's method will be used to slove the equations.
                
        func solution(maxIndex: Int, coefficient: [Double], initialValue: Double) -> Double {
            
            /*
             Example: y = a * x ^ 2 + b * x + c
                maxIndex = 2
                coefficient = [a, b, c]
                primitiveFunctionIndexArray = [2, 1, 0]
                derivativeFunctionIndexArray = [1, 0]
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
        
        if(polyproticAcidBase == 1) {
            
            // Monoprotic acid or base
            // cx ^ 3 + K * cx ^ 2 - (K * c + Kw) * cx - K * Kw = 0
            
            cxValue = solution(maxIndex: 3, coefficient: [1, KValue[0], (-KValue[0] * cValue + KwValue), -(KValue[0] * KwValue)], initialValue: cValue)
            
            
        } else if(polyproticAcidBase == 2) {
            
            // Diprotic acid or base
            // cx ^ 4 + K1 * cx ^ 3 + (K1 * K2 - K1 * c - Kw) * cx ^ 2 - (K1 * Kw + 2 * K1 * K2 * c) * cx - K1 * K2 * Kw = 0
            
            cxValue = solution(maxIndex: 4, coefficient: [1, KValue[0], (KValue[0] * KValue[1] - KValue[0] * cValue - KwValue), -(KValue[0] * KwValue + 2 * KValue[0] * KValue[1] * cValue), -(KValue[0] * KValue[1] * KwValue)], initialValue: cValue)
            
        } else if(polyproticAcidBase == 3) {
            
            // Triprotic acid or base
            // cx ^ 5 + K1 * cx ^ 4 + (K1 * K2 - K1 * c - Kw) * cx ^ 3 + (K1 * K2 * K3 - 2 * K1 * K2 - K1 * Kw) * cx ^ 2 - (3 * K1 * K2 * K3 + K1 * K2 * Kw) * cx - K1 * K2 * K3 * Kw = 0
            
            cxValue = solution(maxIndex: 5, coefficient: [1, KValue[0], (KValue[0] * KValue[1] - KValue[0] * cValue - KwValue), (KValue[0] * KValue[1] * KValue[2] - 2 * KValue[0] * KValue[1] - KValue[0] * KwValue), -(3 * KValue[0] * KValue[1] * KValue[2] + KValue[0] * KValue[2] * KwValue), -(KValue[0] * KValue[1] * KValue[2])], initialValue: cValue)
            
        }
        
        // This part will convert the concentration of proton (H+) or hydroxide (OH-) to pH Value.
        
        if(acidBase == 0) {
            
            pHValue = -log10(cxValue)
            
        } else {
            
            pHValue = 14 + log10(cxValue)
            
        }
    }
}
