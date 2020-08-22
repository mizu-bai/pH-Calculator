//
//  EquationParameter.h
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/2.
//

#ifndef EquationParameter_h
#define EquationParameter_h

#import <Foundation/Foundation.h>

#import "EquationParameter.h"

@interface EquationParameter: NSObject {

    int _degree;
    double *_coefficient;
    double _initialValue;
    
}

@property(nonatomic, assign) double ans;

- (id)init;
- (void)initParameterWithDegree: (int)inputDegree Coefficient: (double *)inputCoefficient InitialValue: (double)inputInitialValue;
- (double)calculateAndReturnAns;

@end

#endif /* EquationParameter_h */
