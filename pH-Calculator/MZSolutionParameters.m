//
//  MZSolutionParameters.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/2/27.
//

#import "MZSolutionParameters.h"
#import "MZSolution.h"


@implementation MZSolutionParameters
- (instancetype)initWithSolution:(MZSolution *)solution {
    self = [super init];
    if (self) {
        // set solution type
        self.soluteType = solution.soluteType;
        // set protonNumber
        self.protonNumber = (int) solution.dissociationConstants.count;
        // set concentration
        self.concentration = [solution.concentration doubleValue];
        // set constant
        double tmp[solution.dissociationConstants.count];
//        for (NS)
//        self.dissociationConstantK = (double *) arrayTmp;
    }
    return self;
}

+ (instancetype)solutionParameterWithSolution:(MZSolution *)solution {
    return [[self alloc] initWithSolution:solution];
}

@end
