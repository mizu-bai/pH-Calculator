//
//  searchDB.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/2.
//

import Foundation

func searchDB(_ searchParameter: SearchParameter, _ cValue: Double) -> SolutionParameter {
    
    
    let selectData = DBManager.init()
    selectData?.openDatabase()
    selectData?.selectData(with: searchParameter.sql as String?)
    var KValue: [Double] = [Double]()
    
    // Convert KValue from Objective-C NSArray containing NSString to Swift Double Array.
    
    for element in selectData?.sqlResult as! [NSString] {
        
        // The prototype of element.doubleValue is [NSString doubleValue].
        
        KValue.append(element.doubleValue)
        
    }
    
    let solutionParameter = SolutionParameter(WithAcidBase: Int(searchParameter.acidBase), Polyprotic: Int(searchParameter.polyprotic), KValue: KValue, CValue: cValue)
   
    return solutionParameter

}
