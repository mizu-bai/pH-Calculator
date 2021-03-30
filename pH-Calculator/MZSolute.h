//
//  MZSolute.h
//  pH-Calculator
//
//  Created by mizu-bai on 2021/3/1.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZSolute : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSArray *Ka;
@property(nonatomic, strong) NSArray *pKa;
@property(nonatomic, strong) NSArray *Kb;
@property(nonatomic, strong) NSArray *pKb;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)soluteWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
