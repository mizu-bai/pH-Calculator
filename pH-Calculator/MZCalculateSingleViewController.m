//
//  MZCalculateSingleViewController.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/2/26.
//

#import "MZCalculateSingleViewController.h"
#import "MZSolution.h"
#import "MTMathUILabel.h"

@interface MZCalculateSingleViewController () <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UIView *viewConcentrationPrompt;
@property(weak, nonatomic) IBOutlet UIView *viewResultPrompt;

@property(weak, nonatomic) IBOutlet UISegmentedControl *segSoluteType;
@property(weak, nonatomic) IBOutlet UISegmentedControl *segConstantType;

@property(weak, nonatomic) IBOutlet UITextField *fieldConcentration;
@property(weak, nonatomic) IBOutlet UITextField *fieldConstant1;
@property(weak, nonatomic) IBOutlet UITextField *fieldConstant2;
@property(weak, nonatomic) IBOutlet UITextField *fieldConstant3;
@property(weak, nonatomic) IBOutlet UITextField *fieldResult;

@property(weak, nonatomic) IBOutlet UIButton *buttonClear;
@property(weak, nonatomic) IBOutlet UIButton *buttonCalculate;

- (IBAction)segAcidOrBaseChange:(id)sender;

- (IBAction)buttonClearClick:(id)sender;

- (IBAction)buttonCalculateClick:(id)sender;

@end

@implementation MZCalculateSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // prompt view
    [self addViewConcentrationPrompt];
    [self addViewResultPrompt];
    // delegate
    self.fieldConcentration.delegate = self;
    self.fieldConstant1.delegate = self;
    self.fieldConstant2.delegate = self;
    self.fieldConstant3.delegate = self;
    self.fieldResult.delegate = self;
    // clear
    [self buttonClearClick:nil];
    // configure clear button state
    [self enableClearButton];
    // configure calculate button state
    [self enableCalculateButton];
    // configure optional constant fields
    [self enableConstantField];
}

- (void)setSegConstantTypePromptForSoluteType:(UISegmentedControl *)soluteType {
    NSString *latexForK = @"K_a";
    NSString *latexFor_pK = @"pK_a";
    if ((MZSoluteType) soluteType.selectedSegmentIndex == MZSoluteTypeBase) {
        latexForK = @"K_b";
        latexFor_pK = @"pK_b";
    }
    // set
    [self.segConstantType setImage:[self imageWithUIView:[self mathUiLabelWithLatex:latexForK AndFontSize:16]] forSegmentAtIndex:0];
    [self.segConstantType setImage:[self imageWithUIView:[self mathUiLabelWithLatex:latexFor_pK AndFontSize:16]] forSegmentAtIndex:1];
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

#pragma - prompt viewå

- (void)addViewConcentrationPrompt {
    MTMathUILabel *labelConcentrationPrompt = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    labelConcentrationPrompt.latex = @"c \\ / \\ \\mathrm{mol \\cdot L ^ {-1}}";
    labelConcentrationPrompt.fontSize = 16;
    [labelConcentrationPrompt sizeToFit];
    [self.viewConcentrationPrompt addSubview:labelConcentrationPrompt];
}

- (void)addViewResultPrompt {
    MTMathUILabel *labelResultPrompt = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    labelResultPrompt.latex = @"\\mathrm{pH}";
    labelResultPrompt.fontSize = 16;
    [labelResultPrompt sizeToFit];
    [self.viewResultPrompt addSubview:labelResultPrompt];
}

#pragma - button and segmented control action

- (IBAction)segAcidOrBaseChange:(id)sender {
    [self setSegConstantTypePromptForSoluteType:self.segSoluteType];
}

// clear all
- (IBAction)buttonClearClick:(id)sender {
    // segmented control
    [self.segSoluteType setSelectedSegmentIndex:0];
    [self.segConstantType setSelectedSegmentIndex:0];
    [self segAcidOrBaseChange:nil];
    // text field
    [self.fieldConcentration setText:nil];
    [self.fieldConstant1 setText:nil];
    [self.fieldConstant2 setText:nil];
    [self.fieldConstant3 setText:nil];
    [self.fieldResult setText:nil];
    // disable clear button
    [self.buttonClear setEnabled:NO];
    // disable calculate button
    [self.buttonCalculate setEnabled:NO];
    // disable optional constant fields
    [self.fieldConstant2 setEnabled:NO];
    [self.fieldConstant3 setEnabled:NO];
    // end editing
    [self.view endEditing:YES];
}

#pragma mark - configure control state

// monitor fields and segmented controls for clear button
- (void)enableClearButton {
    [self.fieldConcentration addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant1 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant2 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant3 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldResult addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.segSoluteType addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventValueChanged];
    [self.segConstantType addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventValueChanged];
}

- (void)configureClearButton {
    self.buttonClear.enabled = (self.segSoluteType.selectedSegmentIndex != 0) || (self.segConstantType != (UISegmentedControl *) 0) || (self.fieldConcentration.text.length > 0) || (self.fieldConstant1.text.length > 0) || (self.fieldConstant2.text.length > 0) || (self.fieldConstant3.text.length > 0) || (self.fieldResult.text.length > 0);
}

// monitor fields and segmented controls for calculate button
- (void)enableCalculateButton {
    [self.fieldConcentration addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant1 addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant2 addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant3 addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
}

- (void)configureCalculateButton {
    self.buttonCalculate.enabled = (self.fieldConcentration.text.length > 0) && (self.fieldConstant1.text.length > 0);
}

// monitor dissociation constantfields and for dissociation constantfields
- (void)enableConstantField {
    [self.fieldConstant1 addTarget:self action:@selector(configureDissociationConstantField) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant2 addTarget:self action:@selector(configureDissociationConstantField) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant3 addTarget:self action:@selector(configureDissociationConstantField) forControlEvents:UIControlEventEditingChanged];
}

- (void)configureDissociationConstantField {
    self.fieldConstant2.enabled = self.fieldConstant1.text.length > 0;
    self.fieldConstant3.enabled = self.fieldConstant2.text.length > 0;
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

// calculate pH Value
- (IBAction)buttonCalculateClick:(id)sender {
    // calculate
    [self.view endEditing:YES];
}

@end
