//
//  EquationParameter.m
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/2.
//

#import "EquationParameter.h"
#import "solveCore.h"

@implementation EquationParameter

- (id)init {

    self = [super init];

    if(self) {
        
//        NSLog(@"Class EuqationParameter initialized.");
        
    }

    return self;
    
}

- (void)initParameterWithDegree: (int)inputDegree Coefficient: (double *)inputCoefficient InitialValue: (double)inputInitialValue {
    
    _degree = inputDegree;
    _coefficient = inputCoefficient;
    _initialValue = inputInitialValue;
    
}

- (double)calculateAndReturnAns {
    
    self.ans = solveCore(_degree, _coefficient, _initialValue);
    
    return self.ans;
    
}

@end
