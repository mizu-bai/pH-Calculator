//
//  MZSolution.h
//  pH-Calculator
//
//  Created by mizu-bai on 2021/2/27.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef enum {
    MZSoluteTypeAcid = 0, // acid
    MZSoluteTypeBase = 1  // base
} MZSoluteType;

typedef enum {
    MZConstantTypeK = 0, // K
    MZConstantType_pK = 1  // pK
} MZConstantType;

@interface MZSolution : NSObject

@property(nonatomic, assign) MZSoluteType soluteType;
@property(nonatomic, assign) MZConstantType constantType;
@property(nonatomic, copy) NSNumber *concentration;
@property(nonatomic, copy) NSArray<NSNumber *> *dissociationConstants;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)solutionWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
