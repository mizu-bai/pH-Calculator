//
//  parameter.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/6/30.
//

import Foundation

struct parameter {
    
    var acidBase: Int // The type of the solution, acid corresponds to value 0 and base corresponds to value 1.
    var polyprotic: Int // The number of proton the acid can provide or the base can accept.
    var KValue: [Double] // The dissocuation constants of the acid or base as the type of Ka or Kb.
    var cValue: Double // The input value of solution concentration.
    
    init(fromacidBase acidBase: Int, frompolyprotic polyprotic: Int, fromKValue KValue: [Double], fromcValue cValue: Double) {
        
        self.acidBase = acidBase
        self.polyprotic = polyprotic
        self.KValue = KValue
        self.cValue = cValue
        
    }
}
