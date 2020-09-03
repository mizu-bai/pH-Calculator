//
//  DBManager.h
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/4.
//

#ifndef DBManager_h
#define DBManager_h

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define databaseName @"DissociationConstant.db"

@interface DBManager: NSObject {
    
    NSString *_DatabasePath;
    sqlite3 *db;
    int rc;
    
}

@property (nonatomic, copy) NSArray *sqlResult;

- (id)init;
- (BOOL)openDatabase;
- (BOOL)selectDataWith: (NSString *) zSQL;
- (void)closeDatabase;

@end

#endif /* DBManager_h */
