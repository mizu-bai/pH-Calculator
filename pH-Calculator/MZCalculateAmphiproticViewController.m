//
//  MZCalculateAmphiproticViewController.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/2/26.
//

#import "MZCalculateAmphiproticViewController.h"
#import "MZSolute.h"
#import "MTMathUILabel.h"

@interface MZCalculateAmphiproticViewController () <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UIView *viewConcentrationPromptAcid;
@property(weak, nonatomic) IBOutlet UIView *viewConcentrationPromptBase;
@property(weak, nonatomic) IBOutlet UIView *viewResultPrompt;

@property(weak, nonatomic) IBOutlet UISegmentedControl *segConstantTypeAcid;
@property(weak, nonatomic) IBOutlet UISegmentedControl *segConstantTypeBase;

@property (weak, nonatomic) IBOutlet UITextField *fieldConcentrationAcid;
@property (weak, nonatomic) IBOutlet UITextField *fieldConcentrationBase;
@property (weak, nonatomic) IBOutlet UITextField *fieldConstantAcid;
@property (weak, nonatomic) IBOutlet UITextField *fieldConstantBase;
@property (weak, nonatomic) IBOutlet UITextField *fieldResult;

@property (weak, nonatomic) IBOutlet UIButton *buttonClear;
@property (weak, nonatomic) IBOutlet UIButton *buttonCalculate;

- (IBAction)buttonClearClick:(id)sender;
- (IBAction)buttonCalculateClick:(id)sender;

@end

@implementation MZCalculateAmphiproticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // prompt
    [self addViewConcentrationPrompt];
    [self addViewResultPrompt];
    [self setSegConstantTypePrompt];
    // delegate
    self.fieldConcentrationAcid.delegate = self;
    self.fieldConcentrationBase.delegate = self;
    self.fieldConstantAcid.delegate = self;
    self.fieldConstantBase.delegate = self;
    self.fieldResult.delegate = self;
    // clear
    [self buttonClearClick:nil];
    // configure clear button state
    [self enableClearButton];
    // configure calculate button state
    [self enableCalculateButton];

}

#pragma mark - prompt view

- (void)addViewConcentrationPrompt {
    MTMathUILabel *labelConcentrationPromptAcid = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    labelConcentrationPromptAcid.latex = @"c(\\mathrm{HA}) \\ / \\ \\mathrm{mol \\cdot L ^ {-1}}";
    labelConcentrationPromptAcid.fontSize = 16;
    [labelConcentrationPromptAcid sizeToFit];
    [self.viewConcentrationPromptAcid addSubview:labelConcentrationPromptAcid];
    MTMathUILabel *labelConcentrationPromptBase = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    labelConcentrationPromptBase.latex = @"c(\\mathrm{B ^ -}) \\ / \\ \\mathrm{mol \\cdot L ^ {-1}}";
    labelConcentrationPromptBase.fontSize = 16;
    [labelConcentrationPromptBase sizeToFit];
    [self.viewConcentrationPromptBase addSubview:labelConcentrationPromptBase];
}

- (void)addViewResultPrompt {
    MTMathUILabel *labelResultPrompt = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    labelResultPrompt.latex = @"\\mathrm{pH}";
    labelResultPrompt.fontSize = 16;
    [labelResultPrompt sizeToFit];
    [self.viewResultPrompt addSubview:labelResultPrompt];
}

- (void)setSegConstantTypePrompt {
    [self.segConstantTypeAcid setImage:[self imageWithUIView:[self mathUiLabelWithLatex:@"K_a" AndFontSize:16]] forSegmentAtIndex:0];
    [self.segConstantTypeAcid setImage:[self imageWithUIView:[self mathUiLabelWithLatex:@"pK_a" AndFontSize:16]] forSegmentAtIndex:1];
    [self.segConstantTypeBase setImage:[self imageWithUIView:[self mathUiLabelWithLatex:@"K_b" AndFontSize:16]] forSegmentAtIndex:0];
    [self.segConstantTypeBase setImage:[self imageWithUIView:[self mathUiLabelWithLatex:@"pK_b" AndFontSize:16]] forSegmentAtIndex:1];
}

- (MTMathUILabel *)mathUiLabelWithLatex:(NSString *)string AndFontSize:(int)fontSize {
    MTMathUILabel *mathUiLabel = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    [mathUiLabel setLatex:string];
    [mathUiLabel setFontSize:fontSize];
    [mathUiLabel sizeToFit];
    return mathUiLabel;
}

- (UIImage *)imageWithUIView:(UIView *)view {
    // get image
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // transform
    CGImageRef cgImage = image.CGImage;
    UIGraphicsBeginImageContext(image.size);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), cgImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// monitor fields and segmented controls for clear button
- (void)enableCalculateButton {
    [self.fieldConcentrationAcid addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConcentrationBase addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstantAcid addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstantBase addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldResult addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.segConstantTypeAcid addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventValueChanged];
    [self.segConstantTypeBase addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventValueChanged];
}

- (void)configureClearButton {
    [self.buttonClear setEnabled:(self.segConstantTypeAcid.selectedSegmentIndex != 0) || (self.segConstantTypeBase.selectedSegmentIndex != 0) || (self.fieldConcentrationAcid.text.length > 0) || (self.fieldConcentrationBase.text.length > 0) || (self.fieldConstantAcid.text.length > 0) || (self.fieldConstantBase.text.length > 0) || (self.fieldResult.text.length > 0)];
}

// monitor fields and segmented controls for calculate button
- (void)enableClearButton {
    [self.fieldConstantAcid addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstantBase addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConcentrationAcid addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConcentrationBase addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
}

- (void)configureCalculateButton {
    [self.buttonCalculate setEnabled:(self.fieldConcentrationAcid.text.length > 0) && (self.fieldConcentrationBase.text.length > 0) && (self.fieldConstantAcid.text.length > 0) && (self.fieldConstantBase.text.length > 0)];
}

// clear all
- (IBAction)buttonClearClick:(id)sender {
    // segmented control
    [self.segConstantTypeAcid setSelectedSegmentIndex:0];
    [self.segConstantTypeBase setSelectedSegmentIndex:0];
    // text field
    [self.fieldConstantAcid setText:nil];
    [self.fieldConstantBase setText:nil];
    [self.fieldConcentrationAcid setText:nil];
    [self.fieldConcentrationBase setText:nil];
    [self.fieldResult setText:nil];
    // disable clear button
    [self.buttonClear setEnabled:NO];
    // disable calculate button
    [self.buttonCalculate setEnabled:NO];
    // end editing
    [self.view endEditing:YES];
}

#pragma mark - text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return textField == self.fieldResult ? NO : YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - calculate
- (IBAction)buttonCalculateClick:(id)sender {

}

@end
