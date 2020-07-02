//
//  accessDB.swift
//  pH-Calculator
//
//  Created by mizu-bai on 2020/6/29.
//

import Foundation
import SQLite3

func accessDB(species: String, ID: Int, cValue: Double) -> (acidBase: Int, polyprotic: Int, KValue: [Double], cValue: Double)  {
    
    var acidBase: Int = 0
    var polyprotic: Int = 1
    var KValue: [Double] = [Double]()
    
    // Match the type of acid or base and number of proton the acid can provide or the base can accept.
    // NOTE: Both species and name are identical with those in database.
    
    // This part will match acidBase and polyproticacid of an acid or base to its species.
    
    if(species.hasPrefix("MONO")) {
        
        polyprotic = 1
        
    } else if(species.hasPrefix("DI")) {
        
        polyprotic = 2
        
    } else if(species.hasPrefix("TRI")) {
        
        polyprotic = 3
        
    } else if(species.hasPrefix("TETRA")) {
        
        polyprotic = 4
        
    } else {
        
        print("ERROR IN JUDGING THE NUMBER OF PROTON!")
        
    }
    
    if(species.hasSuffix("ACID")) {
        
        acidBase = 0
        
    } else if(species.hasSuffix("BASE")) {
        
        acidBase = 1
        
    } else {
        
        print("ERROR IN JUDGING THE ACID OR BASE TYPE!")
        
    }
        
    // Access to DataBase
        
    return (acidBase, polyprotic, KValue, cValue)

}
