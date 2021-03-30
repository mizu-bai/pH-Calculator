//
//  MZGroup.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/3/1.
//

#import "MZGroup.h"
#import "MZSolute.h"

@implementation MZGroup
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
        // dict -> model
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dictItem in dictionary[@"solutes"]) {
            MZSolute *solute = [MZSolute soluteWithDictionary:dictItem];
            [arrayModels addObject:solute];
        }
        self.solutes = arrayModels;
    }
    return self;
}

+ (instancetype)groupWithDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithDictionary:dictionary];
}


@end
