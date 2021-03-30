//
//  MZDissociationConstantTableViewController.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/3/1.
//

#import "MZDissociationConstantTableViewController.h"
#import "MZGroup.h"
#import "MZSolute.h"

typedef enum {
    MZSoluteTypeAcid = 0, // acid
    MZSoluteTypeBase = 1  // base
} MZSoluteType;

@interface MZDissociationConstantTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *groups;

@end

@implementation MZDissociationConstantTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Lazy load

- (NSArray *)groups {
    if (_groups == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dissociation_constants" ofType:@"plist"];
        NSArray *arrayDictionary = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dictionary in arrayDictionary) {
            MZGroup *group = [MZGroup groupWithDictionary:dictionary];
            [arrayModels addObject:group];
        }
        _groups = arrayModels;
    }
    return _groups;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MZGroup *group = self.groups[(NSUInteger) section];
    return group.solutes.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // get model data
    MZGroup *group = self.groups[(NSUInteger) indexPath.section];
    MZSolute *solute = group.solutes[(NSUInteger) indexPath.row];
    // create table view cell
    static NSString *ID = @"solute_cell";
    // get cell from cache
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // create cell
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    // set cell
    [cell.textLabel setText:solute.name];
    [cell.detailTextLabel setNumberOfLines:2];
    [cell.detailTextLabel setText:[self detailTextWithSolute:solute]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

// detail text
- (NSString *)detailTextWithSolute:(MZSolute *)solute {
    MZSoluteType soluteType = solute.Ka.count != 0 ? MZSoluteTypeAcid : MZSoluteTypeBase;
    NSArray *K = soluteType == MZSoluteTypeAcid ? solute.Ka : solute.Kb;
    NSArray *pK = soluteType == MZSoluteTypeAcid ? solute.pKa : solute.pKb;
    NSString *detailTextSuffix = soluteType == MZSoluteTypeAcid ? @"a" : @"b";
    NSMutableArray *arrayDetailK = [NSMutableArray array];
    NSMutableArray *arrayDetail_pK = [NSMutableArray array];
    NSMutableString *detailText = [NSMutableString string];
    for (int i = 0; i < K.count; ++i) {
        [arrayDetailK addObject:[NSString stringWithFormat:@"K%@%d: %.2E", detailTextSuffix, i + 1, [K[(NSUInteger) i] doubleValue]]];
    }
    [detailText appendString:[arrayDetailK componentsJoinedByString:@", "]];
    [detailText appendString:@"\n"];
    for (int i = 0; i < K.count; ++i) {
        [arrayDetail_pK addObject:[NSString stringWithFormat:@"pK%@%d: %.2f", detailTextSuffix, i + 1, [pK[(NSUInteger) i] doubleValue]]];
    }
    [detailText appendString:[arrayDetail_pK componentsJoinedByString:@", "]];
    return detailText;
};

// set title
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    MZGroup *group = self.groups[(NSUInteger) section];
    return group.title;
}

@end
