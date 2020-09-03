//
//  DBManager.m
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/4.
//

#import "DBManager.h"

@implementation DBManager

- (id)init {
    
    if(self = [super init]) {
        
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
        _DatabasePath = [documentPath stringByAppendingPathComponent: databaseName];
        
    }
    
    return self;
}

- (BOOL)openDatabase {
    
    rc = sqlite3_open((const char *)[_DatabasePath UTF8String], &db);
    
    if (rc != SQLITE_OK) {
        
//        NSLog(@"Can't Open Database.");
        
    }
    
    return rc;
}

- (BOOL)selectDataWith:(NSString *)zSQL {
    
    char *pzErrmsg;
    char **pazResult;
    int pnRow;
    int pnColumn;
    
    rc = sqlite3_get_table(db, (const char *)[zSQL UTF8String], &pazResult, &pnRow, &pnColumn, &pzErrmsg);
    
    if (rc != SQLITE_OK) {
        
//        NSLog(@"%s.", pzErrmsg);
        
    }
        
    NSMutableArray *sqlResultTemp = [[NSMutableArray alloc] init];
    
    for (int i = pnColumn; i < 2 * pnColumn; i++) {

        [sqlResultTemp addObject: [NSString stringWithUTF8String: (const char *)pazResult[i]]];
        
    }
  
    self.sqlResult = [[NSArray alloc] initWithArray: sqlResultTemp];
    
    return rc;
    
}

- (void)closeDatabase {
    
    sqlite3_close(db);
    
}

@end
