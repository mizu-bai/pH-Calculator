//
//  MZSingleSolutionResult.h
//  pH-Calculator
//
//  Created by 李俊宏 on 2021/3/2.
//
//

#import <Foundation/Foundation.h>
#import "solve.h"
#import "singleSolutionEquation.h"

NS_ASSUME_NONNULL_BEGIN

@class MZSolutionParameters;
@interface MZSingleSolutionResult : NSObject

@property (nonatomic, strong) MZSolutionParameters *solutionParameters;
@property (nonatomic, assign) double result;

+ (instancetype)solutionResult;

@end

NS_ASSUME_NONNULL_END
