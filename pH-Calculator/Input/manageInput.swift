//
//  manageInput.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/6/30.
//

import Foundation

func manageInput(_ inputParameter: InputParameter) -> SolutionParameter {
    
    inputParameter.formKValue()
    
    let solutionParameter = SolutionParameter(WithAcidBase: inputParameter.acidBase, Polyprotic: inputParameter.polyprotic, KValue: inputParameter.KValue, CValue: inputParameter.cValue)
    
    return solutionParameter
    
}
