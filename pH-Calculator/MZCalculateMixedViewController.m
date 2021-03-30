//
//  MZCalculateMixedViewController.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/2/26.
//

#import "MZCalculateMixedViewController.h"
#import "MZSolution.h"
#import "MTMathUILabel.h"

@interface MZCalculateMixedViewController () <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UISegmentedControl *segSoluteType0;
@property(weak, nonatomic) IBOutlet UISegmentedControl *segSoluteType1;
@property(weak, nonatomic) IBOutlet UISegmentedControl *segConstantType0;
@property(weak, nonatomic) IBOutlet UISegmentedControl *segConstantType1;

@property(weak, nonatomic) IBOutlet UITextField *fieldConcentration0;
@property(weak, nonatomic) IBOutlet UITextField *fieldConstant0;
@property(weak, nonatomic) IBOutlet UITextField *fieldConcentration1;
@property(weak, nonatomic) IBOutlet UITextField *fieldConstant1;
@property(weak, nonatomic) IBOutlet UITextField *fieldResult;

@property(weak, nonatomic) IBOutlet UIButton *buttonClear;
@property(weak, nonatomic) IBOutlet UIButton *buttonCalculate;

@property(weak, nonatomic) IBOutlet UIView *viewConcentrationPrompt0;
@property(weak, nonatomic) IBOutlet UIView *viewConcentrationPrompt1;
@property(weak, nonatomic) IBOutlet UIView *viewResultPrompt;


- (IBAction)segAcidOrBaseChange:(id)sender;

- (IBAction)buttonClearClick:(id)sender;

- (IBAction)buttonCalculateClick:(id)sender;

@end

@implementation MZCalculateMixedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // prompt view
    [self addViewConcentrationPrompt];
    [self addViewResultPrompt];
    // delegate
    self.fieldConcentration0.delegate = self;
    self.fieldConcentration1.delegate = self;
    self.fieldConstant0.delegate = self;
    self.fieldConstant1.delegate = self;
    self.fieldResult.delegate = self;
    // set tag
    [self.segSoluteType0 setTag:0];
    [self.segSoluteType1 setTag:1];
    // clear
    [self buttonClearClick:nil];
    // configure clear button state
    [self enableClearButton];
    // configure calculate button state
    [self enableCalculateButton];
}

#pragma mark - prompt view

- (void)addViewConcentrationPrompt {
    MTMathUILabel *labelConcentrationPrompt0 = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    labelConcentrationPrompt0.latex = @"c_1 \\ / \\ \\mathrm{mol \\cdot L ^ {-1}}";
    labelConcentrationPrompt0.fontSize = 16;
    [labelConcentrationPrompt0 sizeToFit];
    [self.viewConcentrationPrompt0 addSubview:labelConcentrationPrompt0];
    MTMathUILabel *labelConcentrationPrompt1 = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    labelConcentrationPrompt1.latex = @"c_2 \\ / \\ \\mathrm{mol \\cdot L ^ {-1}}";
    labelConcentrationPrompt1.fontSize = 16;
    [labelConcentrationPrompt1 sizeToFit];
    [self.viewConcentrationPrompt1 addSubview:labelConcentrationPrompt1];
}

- (void)addViewResultPrompt {
    MTMathUILabel *labelResultPrompt = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    labelResultPrompt.latex = @"\\mathrm{pH}";
    labelResultPrompt.fontSize = 16;
    [labelResultPrompt sizeToFit];
    [self.viewResultPrompt addSubview:labelResultPrompt];
}

// clear all
- (IBAction)buttonClearClick:(id)sender {
    // segmented control
    [self.segSoluteType0 setSelectedSegmentIndex:0];
    [self.segSoluteType1 setSelectedSegmentIndex:0];
    [self.segConstantType0 setSelectedSegmentIndex:0];
    [self.segConstantType1 setSelectedSegmentIndex:0];
    [self segAcidOrBaseChange:nil];
    // text field
    [self.fieldConcentration0 setText:nil];
    [self.fieldConcentration1 setText:nil];
    [self.fieldConstant0 setText:nil];
    [self.fieldConstant1 setText:nil];
    [self.fieldResult setText:nil];
    // disable clear button
    [self.buttonClear setEnabled:NO];
    // disable calculate button
    [self.buttonCalculate setEnabled:NO];
    // end editing
    [self.view endEditing:YES];
}

- (IBAction)segAcidOrBaseChange:(UISegmentedControl *)sender {
    [self setConstantType:self.segConstantType0 ForSoluteType:self.segSoluteType0];
    [self setConstantType:self.segConstantType1 ForSoluteType:self.segSoluteType1];
}

- (void)setConstantType:(UISegmentedControl *)segConstantType ForSoluteType:(UISegmentedControl *)soluteType {
    // get tag
    int tag = (int) soluteType.tag;
    // prompt
    NSString *latexForK = @"K_a";
    NSString *latexFor_pK = @"pK_a";
    if ((MZSoluteType) soluteType.selectedSegmentIndex == MZSoluteTypeBase) {
        latexForK = @"K_b";
        latexFor_pK = @"pK_b";
    }
    if (tag == 0) {
        [self.segConstantType0 setImage:[self imageWithUIView:[self mathUiLabelWithLatex:latexForK AndFontSize:16]] forSegmentAtIndex:0];
        [self.segConstantType0 setImage:[self imageWithUIView:[self mathUiLabelWithLatex:latexFor_pK AndFontSize:16]] forSegmentAtIndex:1];
    } else {
        [self.segConstantType1 setImage:[self imageWithUIView:[self mathUiLabelWithLatex:latexForK AndFontSize:16]] forSegmentAtIndex:0];
        [self.segConstantType1 setImage:[self imageWithUIView:[self mathUiLabelWithLatex:latexFor_pK AndFontSize:16]] forSegmentAtIndex:1];
    }
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
- (void)enableClearButton {
    [self.fieldConcentration0 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConcentration0 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant0 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant1 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldResult addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.segSoluteType0 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventValueChanged];
    [self.segSoluteType1 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventValueChanged];
    [self.segConstantType0 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventValueChanged];
    [self.segConstantType1 addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventValueChanged];
}

- (void)configureClearButton {
    self.buttonClear.enabled = (self.segSoluteType0.selectedSegmentIndex != 0) || (self.segSoluteType1.selectedSegmentIndex != 0)
            || (self.segConstantType0 != (UISegmentedControl *) 0) || (self.segConstantType1 != (UISegmentedControl *) 0)
            || (self.fieldConcentration0.text.length > 0) || (self.fieldConcentration1.text.length > 0)
            || (self.fieldResult.text.length > 0);
}

// monitor fields and segmented controls for calculate button
- (void)enableCalculateButton {
    [self.fieldConcentration0 addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConcentration0 addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant0 addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldConstant1 addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
}

- (void)configureCalculateButton {
    self.buttonCalculate.enabled = (self.fieldConcentration0.text.length > 0) && (self.fieldConcentration1.text.length > 0)
            && (self.fieldConstant0.text.length > 0) && (self.fieldConstant1.text.length > 0);
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

    // end editing
    [self.view endEditing:YES];
}

@end
