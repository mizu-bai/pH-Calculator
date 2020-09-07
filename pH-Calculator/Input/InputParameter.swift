//
//  InputParameter.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/2.
//

import Foundation

class InputParameter: NSObject {
    
    var acidBase: Int
    var KpK: Int
    var KpKInputText: String
    var cValue: Double
    var KpKInputValue: [Double] = [Double]()
    var polyprotic: Int = 0
    var KValue: [Double] = [Double]()
    
    init(withAcidBase inputAcidBase: Int, KpK inputKpK: Int, KpKInputText inputKpKInputText: String, CValue inputCValue: Double) {
        
        // Direct input parameters
        
//        NSLog("Class InputParameter initialized")
        
        self.acidBase     = inputAcidBase
        self.KpK          = inputKpK
        self.KpKInputText = inputKpKInputText
        self.cValue       = inputCValue
        
    }
    
    func formKValue() {
        
        // Paramters resolved by inputs
        
        KpKInputValue = string2array(KpKInputText, KpK)
        polyprotic    = KpKInputValue.count
        
        // Deal with input K or pK Value
        
        if(KpK == 0) {
                    
            for index in 0 ..< polyprotic {
                        
                KValue.append(KpKInputValue[index])
                        
            }
                    
        } else if(KpK == 1){
                    
            for index in 0 ..< polyprotic {
                        
                KValue.append(pow(10, (-KpKInputValue[index])))
                        
            }
            
        } else {
            
//            print("ERROE IN JUDGING THE K OR PK TYPE!")
            
        }
    }
}
