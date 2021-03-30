//
//  MZCalculateAcidBaseBufferViewController.m
//  pH-Calculator
//
//  Created by mizu-bai on 2021/2/26.
//

#import "MZCalculateAcidBaseBufferViewController.h"
#import "MZSolution.h"
#import "MTMathUILabel.h"

@interface MZCalculateAcidBaseBufferViewController () <UITextFieldDelegate>


@property(weak, nonatomic) IBOutlet UIView *viewConcentrationPromptAcid;
@property(weak, nonatomic) IBOutlet UIView *viewConcentrationPromptBase;
@property(weak, nonatomic) IBOutlet UIView *viewResultPrompt;

@property(weak, nonatomic) IBOutlet UISegmentedControl *segConstantType;

@property(weak, nonatomic) IBOutlet UITextField *fieldSoluteConcentration;
@property(weak, nonatomic) IBOutlet UITextField *fieldSaltConcentration;
@property(weak, nonatomic) IBOutlet UITextField *fieldDissociationConstant;
@property(weak, nonatomic) IBOutlet UITextField *fieldResult;

@property(weak, nonatomic) IBOutlet UIButton *buttonClear;
@property(weak, nonatomic) IBOutlet UIButton *buttonCalculate;

- (IBAction)buttonClearClick:(id)sender;

- (IBAction)buttonCalculateClick:(id)sender;

@end

@implementation MZCalculateAcidBaseBufferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // prompt
    [self addViewConcentrationPrompt];
    [self addViewResultPrompt];
    [self setSegConstantTypePrompt];
    // delegate
    self.fieldSoluteConcentration.delegate = self;
    self.fieldSaltConcentration.delegate = self;
    self.fieldDissociationConstant.delegate = self;
    self.fieldResult.delegate = self;
    // clear
    [self buttonClearClick:nil];
    // configure clear button state
    [self enableClearButton];
    // configure calculate button state
    [self enableCalculateButton];
}

#pragma - prompt view

- (void)addViewConcentrationPrompt {
    MTMathUILabel *labelConcentrationPromptAcid = (MTMathUILabel *) [[MTMathUILabel alloc] init];
    labelConcentrationPromptAcid.latex = @"c(\\mathrm{HB}) \\ / \\ \\mathrm{mol \\cdot L ^ {-1}}";
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
    // set
    [self.segConstantType setImage:[self imageWithUIView:[self mathUiLabelWithLatex:@"K_a" AndFontSize:16]] forSegmentAtIndex:0];
    [self.segConstantType setImage:[self imageWithUIView:[self mathUiLabelWithLatex:@"pK_a" AndFontSize:16]] forSegmentAtIndex:1];
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

#pragma mark - button action

// clear all
- (IBAction)buttonClearClick:(id)sender {
    // segmented control
    [self.segConstantType setSelectedSegmentIndex:0];
    // text field
    [self.fieldSoluteConcentration setText:nil];
    [self.fieldSaltConcentration setText:nil];
    [self.fieldDissociationConstant setText:nil];
    [self.fieldResult setText:nil];
    // disable clear button
    [self.buttonClear setEnabled:NO];
    // disable calculate button
    [self.buttonCalculate setEnabled:NO];
    // end editing
    [self.view endEditing:YES];
}

#pragma mark - configure button state

// monitor fields and segmented controls for clear button
- (void)enableClearButton {
    [self.fieldSoluteConcentration addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldDissociationConstant addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldResult addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventEditingChanged];
    [self.segConstantType addTarget:self action:@selector(configureClearButton) forControlEvents:UIControlEventValueChanged];
}

- (void)configureClearButton {
    self.buttonClear.enabled = (self.segConstantType.selectedSegmentIndex != 0) || (self.fieldSoluteConcentration.text.length > 0) || (self.fieldSaltConcentration.text.length > 0) || (self.fieldDissociationConstant.text.length > 0) || (self.fieldResult.text.length > 0);
}

// monitor fields and segmented controls for calculate button
- (void)enableCalculateButton {
    [self.fieldSoluteConcentration addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldSaltConcentration addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
    [self.fieldDissociationConstant addTarget:self action:@selector(configureCalculateButton) forControlEvents:UIControlEventEditingChanged];
}

- (void)configureCalculateButton {
    self.buttonCalculate.enabled = (self.fieldSoluteConcentration.text.length > 0) && (self.fieldSaltConcentration.text.length > 0) && (self.fieldDissociationConstant.text.length > 0);
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

// calculate pHValue
- (IBAction)buttonCalculateClick:(id)sender {
    // calculate

    [self.view endEditing:YES];
}

@end
