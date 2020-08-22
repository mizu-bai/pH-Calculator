//
//  SearchParameter.h
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/4.
//

#ifndef SearchParameter_h
#define SearchParameter_h

#import <Foundation/Foundation.h>

@interface SearchParameter: NSObject {

    NSString *_species;
    int _ID;

}

@property(nonatomic, assign) int acidBase;
@property(nonatomic, assign) int polyprotic;
@property(nonatomic, assign) NSString *sql;

- (id)init;
- (void)initWithSpecies: (NSString *)inputSpecies ID: (int)inputID;
- (void)judgeType;
- (void)formSqlCommand;

@end

#endif /* SearchParameter_h */
