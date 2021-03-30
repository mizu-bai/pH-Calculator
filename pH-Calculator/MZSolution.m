//
//  MZSolution.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/2/27.
//

#import "MZSolution.h"

@implementation MZSolution

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)solutionWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}

@end
