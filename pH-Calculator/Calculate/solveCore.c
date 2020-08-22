//
//  solveCore.c
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/2.
//

#include "solveCore.h"

double solveCore(int degree, double coefficient[], double initialValue) {

    // Newton method for solving equation of higher degree with one unknown quantity.
    
    /*
     
        Example equation
     
        a * x ^ 2 + b * x + c = 0
        
        degree = 2
        coefficient = {a, b, c}
        primitiveFunctionIndexArray = {2, 1, 0}
        derivativeFunctionIndexArray = {1, 0}
        
        Re-wrote primitive function and derivate function
     
        y = coefficient[0] * pow(x, primitiveFunctionIndexArray[0]) + coefficient[1] * pow(x, primitiveFunctionIndexArray[1]) + coefficient[2] * pow(x, primitiveFunctionIndexArray[2])
        dy = coefficient[0] * (derivativeFunctionIndexArray[0] + 1) * pow(x, derivativeFunctionIndexArray[0]) + coefficient[1] * (derivativeFunctionIndexArray[1] + 1) * pow(x, derivateFunctionIndexArray[1])
     
        */

    int primitiveFunctionIndexArray[degree + 1];
    int derivativeFunctionIndexArray[degree];
    double x = initialValue;
    double x0;
    double y;
    double dy;
    
    for(int index = 0; index <= degree; index++) {
    
        primitiveFunctionIndexArray[index] = degree - index;
        
    }
    
    for(int index = 0; index <= degree - 1; index++) {
    
        derivativeFunctionIndexArray[index] = degree - 1 - index;
        
    }

    do {
        
        x0 = x;
        y = 0;
        dy = 0;
        
        for(int index = 0; index <= degree; index++) {
        
            y += coefficient[index] * pow(x0, (double)primitiveFunctionIndexArray[index]);
        
        }
        
        for(int index = 0; index <= degree - 1; index++) {
        
            dy += coefficient[index] * (double)(derivativeFunctionIndexArray[index] + 1) * pow(x0, (double)derivativeFunctionIndexArray[index]);
        
        }
        
        x = x0 - y / dy;
        
    } while(fabs(x - x0) >= 1e-5);
    
    return x;

}
