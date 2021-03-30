//
//  MZSingleSolutionResult.m
//  pH-Calculator
//
//  Created by 李俊宏 on 2021/3/2.
//
//

#import "MZSingleSolutionResult.h"
#import "MZSolutionParameters.h"
#import "MZSolution.h"


@implementation MZSingleSolutionResult

- (void)setSolutionParameters:(MZSolutionParameters *)solutionParameters {
    _solutionParameters = solutionParameters;
    double c = solutionParameters.concentration;
    int n = solutionParameters.protonNumber;
    double *K = solutionParameters.dissociationConstantK;
    double cx = solve(c, (double (*)(double)) f1, (double (*)(double)) f2);
    _result = solutionParameters.soluteType == MZSoluteTypeAcid ? -log10(cx) : 14 + log10(cx);
}

+ (instancetype)solutionResult {
    return [[self alloc] init];
}


@end
