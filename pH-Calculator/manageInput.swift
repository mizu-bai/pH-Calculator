//
//  manageInput.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/6/30.
//

import Foundation

func manageInput(acidBase: Int, KpK: Int, KpKInputText: String, cValue: Double) -> (acidBase: Int, polyprotic: Int, KValue: [Double], cValue: Double) {
    
    // This function will manage the inputs and convert them to a standard form in order to save them in struct parameter.
    
    // This part will convert the input in the KpKInputText from type String to [Double].
    
    var KpKInputValue: [Double] = [Double]()
    var polyprotic: Int = 1
    var KValue: [Double] = [Double]()
    
    func KpKInputText2KpKValue(_ Text: String) -> [Double] {
        
        var flag: Bool = false
        var KpKValue: [Double] = [Double]()
        var Temp: String = ""
        // let scan: Scanner = Scanner(Text: String)
        
        if flag {
            
            let Temp = KpKInputText.components(separatedBy: " ")
            
        } else {
            
            print("ERROR IN CONVERTING KPKINPUTTEXT TO KPKVALUE!")
            
        }
        
        // print(Scanner(string: "90.99").scanFloat(&float1))
        
        
        for element in Temp {
            
            KpKInputValue.append(Double(element)!)
            
        }
        
        return KpKValue
    }
 
    // This part will calculate the number of protons that the acid can provide or the base can accept.
    
    polyprotic = KpKInputValue.count
    
    // This part will deal with the input K or pK Value. If the inputs are Ka or Kb, they will be saved to array KValue. If the inputs are pKa of pKb, they will be converted to Ka or Kb before saved.
            
    if(KpK == 0) {
                
        for i in 0 ..< polyprotic {
                    
            KValue.append(KpKInputValue[i])
                    
        }
                
    } else if(KpK == 1){
                
        for i in 0 ..< polyprotic {
                    
            KValue.append(pow(10, (-KpKInputValue[i])))
                    
        }
        
    } else {
        
        print("ERROE IN JUDGING THE K OR PK TYPE!")
        
    }
    
    return (acidBase, polyprotic, KValue, cValue)
    
}
