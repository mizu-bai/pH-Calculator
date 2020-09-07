//
//  string2array.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/2.
//

import Foundation

func string2array(_ inputString: String, _ KpK: Int) -> [Double] {
    
    var outputArray: [Double] = [Double]()
    var flag: Bool            = true
    
    // The strings divided by space.
    
    let temp = inputString.components(separatedBy: " ")
    
    // The regular expression string.
    
    var pattern: String = ""
    
    if(KpK == 0) {
        
        pattern = "[0-9]+[.]*[0-9]*[e, E][+, -][0-9]+"
        
    } else if(KpK == 1) {
        
        pattern = "[0-9]+[.]+[0-9]+"
        
    }
    
    // The regular expression rule.
    
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    
    // Matching
    
    for strTemp in temp {
        
        let result = regex?.matches(in: strTemp, options: [], range: NSRange(location: 0, length: strTemp.count))
        
        if(result?.count == 0) {
            
            flag = false // Find out if outliers exit.
            
            break;
            
        }
    }
    
    if flag {
        
        for element in temp {
            
            outputArray.append(Double(element)!)
            
        }
        
    } else {
        
//        print("ERROR IN CONVERTING KPKINPUTTEXT TO KPKVALUE!")
        
    }
    
    return outputArray
    
}
