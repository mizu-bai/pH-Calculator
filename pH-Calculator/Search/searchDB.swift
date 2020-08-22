//
//  searchDB.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/2.
//

import Foundation

func searchDB(_ searchParameter: SearchParameter, _ cValue: Double) -> SolutionParameter {
    
    let sql = searchParameter.sql;
    let KValue: [Double] = [Double]()
    
    let solutionParameter = SolutionParameter(WithAcidBase: Int(searchParameter.acidBase), Polyprotic: Int(searchParameter.polyprotic), KValue: KValue, CValue: cValue)
   
    return solutionParameter

}

