//
//  SearchParameter.m
//  pH-Calculator
//
//  Created by mizu-bai on 2020/8/4.
//

#import "SearchParameter.h"

@implementation SearchParameter

- (id)init {
    
    self = [super init];
    
    if(self) {
        
//        NSLog(@"Class SearchParameter initialized.");
        
    }
    
    return self;
    
}

- (void)initWithSpecies: (NSString *)inputSpecies ID:(int)inputID {
    
    _species = inputSpecies;
    _ID = inputID;
    
//    NSLog(@"PATH: %@\nSpecies: %@\nID: %d", _dbPATH, _species, _ID);
    
}

- (void)judgeType {
    
    NSArray *polyproticObjArray = @[@"1", @"2", @"3", @"4"];
    NSArray *polyproticKeyArray = @[@"MONO", @"DI", @"TRI", @"TETRA"];
    NSDictionary *polyproticDic = [NSDictionary dictionaryWithObjects: polyproticObjArray forKeys: polyproticKeyArray];
    
    for(NSString *polyproticKey in [polyproticDic allKeys]) {
        
        if([_species hasPrefix: polyproticKey]) {
            
            self.polyprotic = [[polyproticDic objectForKey: polyproticKey] intValue];
            
//            NSLog(@"Found Key is %@, polyprotic is %d", polyproticKey, _polyprotic);
            
            break;
            
        } else {
            
//            NSLog(@"NUMBER OF PROTON NOT FOUND!");

        }
    }
    
    NSArray *acidBaseObjArray = @[@"0", @"1"];
    NSArray *acidBaseKeyArray = @[@"ACID", @"BASE"];
    NSDictionary *acidBaseDic = [NSDictionary dictionaryWithObjects: acidBaseObjArray forKeys: acidBaseKeyArray];
        
    for(NSString *acidBaseKey in [acidBaseDic allKeys]) {
        
        if([_species hasSuffix: acidBaseKey]) {
            
            self.acidBase = [[acidBaseDic objectForKey: acidBaseKey] intValue];
            
//            NSLog(@"Found Key is %@, acidBase is %d", acidBaseKey, _acidBase);
            
            break;
            
        } else {
            
//            NSLog(@"ACID OR BASE TYPE NOT FOUND!");
            
        }
    }
    
//    NSLog(@"AcidBase: %d, Polyprotic: %d.", _acidBase, _polyprotic);
    
}

- (void)formSqlCommand {
        
    NSMutableArray *KValueList     = [NSMutableArray arrayWithCapacity: _polyprotic];
    NSMutableString *KValueElement = [[NSMutableString alloc] init];
    NSString *pre                  = @"K";
    NSString *suf                  = @"VALUE";
    NSMutableString *acidBaseLabel = [[NSMutableString alloc] init];
    
    if(_acidBase == 0) {
        
        [acidBaseLabel appendString: @"A"];
        
    } else if(_acidBase == 1) {
        
        [acidBaseLabel appendString: @"B"];
        
    } else {
        
//        NSLog(@"ERROR IN FORM ACIDBASELABEL!");
        
    }
    
    for(int index = 0; index < _polyprotic; index++) {
        
        KValueElement = [NSMutableString stringWithFormat: @"%@%@%d%@", pre, acidBaseLabel, index + 1, suf];
        
        /*
            About the confusing NSString @"%@%@%d%@".
            
            Example: "KA1VALUE"
                    = "K" + "A" + "1" + "VALUE"
                    = pre + acidBaseLabel + (index + 1) + suf
         
         */
        
        [KValueList addObject: KValueElement];
        
    }
    
    self.sql = [NSString stringWithFormat: @"SELECT %@ FROM %@ WHERE ID = %d;", KValueList, _species, _ID];
    
//    NSLog(@"sql = %@", self.sql);
    
}

@end
