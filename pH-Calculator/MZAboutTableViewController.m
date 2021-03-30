//
//  MZAboutTableViewController.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/3/1.
//

#import "MZAboutTableViewController.h"

@interface MZAboutTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MZAboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger selection = indexPath.row;
    UIApplication *targetApplication = [UIApplication sharedApplication];
    NSURL *moreInfoURL = [NSURL URLWithString:@"https://github.com/mizu-bai/pH-Calculator"];
    NSURL *reportBugsURL = [NSURL URLWithString:@"https://github.com/mizu-bai/pH-Calculator/issues"];
    NSURL *mailURL = [NSURL URLWithString:@"mailto:shiragawa4519@outlook.com"];
    if (selection == 0) {
        // more info
        if ([targetApplication canOpenURL:moreInfoURL]) {
            [targetApplication openURL:moreInfoURL options:@{} completionHandler:nil];
        } else {
            NSLog(@"Failed to get more info!");
        }
    } else if (selection == 1) {
        // report bugs
        if ([targetApplication canOpenURL:reportBugsURL]) {
            [targetApplication openURL:reportBugsURL options:@{} completionHandler:nil];
        } else {
            NSLog(@"Failed to report bugs!");
        }
    } else {
        // contact developer
        if ([targetApplication canOpenURL:mailURL]) {
            [targetApplication openURL:mailURL options:@{} completionHandler:nil];
        } else {
            NSLog(@"Failed to send email!");
        }
    }
}

@end
