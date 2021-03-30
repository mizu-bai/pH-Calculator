//
//  MZSolute.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/3/1.
//
//

#import "MZSolute.h"

@implementation MZSolute
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)soluteWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}


@end
