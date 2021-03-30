//
//  MZSolutionParameters.h
//  pH-Calculator
//
//  Created by mizu-bai on 2021/2/27.
//

#import <Foundation/Foundation.h>
#import "MZSolution.h"


NS_ASSUME_NONNULL_BEGIN

@class MZSolution;

@interface MZSolutionParameters : NSObject

@property(nonatomic, assign) MZSoluteType soluteType;
@property(nonatomic, assign) int protonNumber;
@property(nonatomic, assign) double concentration;
@property(nonatomic, assign) double *dissociationConstantK;

- (instancetype)initWithSolution:(MZSolution *)solution;

+ (instancetype)solutionParameterWithSolution:(MZSolution *)solution;

@end

NS_ASSUME_NONNULL_END
