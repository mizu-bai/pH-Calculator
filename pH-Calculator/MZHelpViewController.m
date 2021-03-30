//
//  MZHelpViewController.m
//  pH-Calculator
//
//  Created by 李俊宏 on 2021/3/4.
//

#import "MZHelpViewController.h"

@interface MZHelpViewController ()
- (IBAction)buttonBackClick:(id)sender;

@end

@implementation MZHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
