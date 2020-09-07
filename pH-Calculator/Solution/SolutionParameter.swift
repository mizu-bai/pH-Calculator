//
//  SolutionParameter.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/2.
//

import Foundation

struct SolutionParameter {
    
    // The parameters of a solution will be saved in this struct SolutionParameter.
    
    var acidBase: Int // The type of the solution, acid corresponds to value 0, base corresponds to value 1, and amphiprotic corresponds to value 2.
    var polyprotic: Int // The number of proton the acid can provide or the base can accept.
    var KValue: [Double] // The dissocuation constants of the acid or base as the type of Ka or Kb.
    var cValue: Double // The input value of solution concentration.
    
    init(WithAcidBase inputAcidBase: Int, Polyprotic inputPolyprotic: Int, KValue inputKValue: [Double], CValue inputCValue: Double) {
        
        self.acidBase   = inputAcidBase
        self.polyprotic = inputPolyprotic
        self.KValue     = inputKValue
        self.cValue     = inputCValue
        
    }
}
