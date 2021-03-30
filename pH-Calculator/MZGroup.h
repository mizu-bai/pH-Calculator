//
//  MZGroup.h
//  pH-Calculator
//
//  Created by mizu-bai on 2021/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZGroup : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *solutes;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)groupWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
