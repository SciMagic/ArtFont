//
//  GradientLabelViewController.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "GradientLabelViewController.h"
#import "CBJGradientLabel.h"

@interface GradientLabelViewController ()

@property (weak, nonatomic) CBJGradientLabel *gradientLabel;

@property (weak, nonatomic) IBOutlet UIView *radialView;
@property (weak, nonatomic) IBOutlet UIView *linearView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *controlViewSegment;


@property (weak, nonatomic) IBOutlet UISlider *radialStartXSlider;
@property (weak, nonatomic) IBOutlet UISlider *radialEndXSlider;
@property (weak, nonatomic) IBOutlet UISlider *radialStartYSlider;
@property (weak, nonatomic) IBOutlet UISlider *radialEndYSlider;
@property (weak, nonatomic) IBOutlet UISlider *radialStartRadius;
@property (weak, nonatomic) IBOutlet UISlider *radialEndRadius;

@property (weak, nonatomic) IBOutlet UISlider *linearStartXSlider;
@property (weak, nonatomic) IBOutlet UISlider *linearEndXSlider;
@property (weak, nonatomic) IBOutlet UISlider *linearStartYSlider;
@property (weak, nonatomic) IBOutlet UISlider *linearEndYSlider;

@end

@implementation GradientLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    self.radialView.hidden = YES;
    
    [self.controlViewSegment addTarget:self action:@selector(changeControlView:) forControlEvents:UIControlEventValueChanged];
    
    CBJGradientLabel *gradientLabel = [[CBJGradientLabel alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.frame), 100)];
    gradientLabel.textAlignment = NSTextAlignmentCenter;
    gradientLabel.text = @"GRADIENT";
    gradientLabel.font = [UIFont systemFontOfSize:60.f];
    gradientLabel.showControlPoint = YES;
    self.gradientLabel = gradientLabel;
    [self.view addSubview:gradientLabel];

    [self commonInit];
    
    [self.colorView addSegmentControl:@[@"startColor", @"endColor"]];
    
}


- (void)changeControlView:(UISegmentedControl *)controlSegment
{
    
    NSString *title = [controlSegment titleForSegmentAtIndex:controlSegment.selectedSegmentIndex];
    if ([title isEqualToString:@"Linear"]) {
        
        self.linearView.hidden = NO;
        self.radialView.hidden = YES;
        self.gradientLabel.type = kGradientTypeLinear;
        
    }else{
        
        self.linearView.hidden = YES;
        self.radialView.hidden = NO;
        self.gradientLabel.type = kGradientTypeRadial;
        
    }
}

- (void)didSelectColor:(UIColor *)color forKey:(NSString *)key
{
    if([key isEqualToString:@"startColor"]){
        
        self.gradientLabel.startColor = color;
        
    }else{
        
        self.gradientLabel.endColor = color;
        
    }
}


- (void)sliderValueChange:(UISlider *)slider
{
    if (slider.tag < 110) {
        
        [self handleLinearSlider:slider];
        
    }else{
        
        [self handleRadialSlider:slider];
    }
}

- (void)handleLinearSlider:(UISlider *)slider
{
    CGPoint startPointOffset = self.gradientLabel.startPointOffset;
    CGPoint endPointOffset = self.gradientLabel.endPointOffset;
    
    if (slider.tag == 100) {
        
        CGPoint point = CGPointMake(slider.value, startPointOffset.y);
        self.gradientLabel.startPointOffset = point;
        
        
    }else if (slider.tag == 101){
        
        CGPoint point = CGPointMake(startPointOffset.x, slider.value);
        self.gradientLabel.startPointOffset = point;
        
    }else if (slider.tag == 102){
        
        CGPoint point = CGPointMake(slider.value, endPointOffset.y);
        self.gradientLabel.endPointOffset = point;
        
    }else if (slider.tag == 103){
        
        CGPoint point = CGPointMake(endPointOffset.x, slider.value);
        self.gradientLabel.endPointOffset = point;
    }
    
}

// NSArray *radialSliders = @[self.radialStartXSlider, self.radialStartYSlider, self.radialEndXSlider, self.radialEndYSlider, self.radialStartRadius, self.radialEndRadius];

- (void)handleRadialSlider:(UISlider *)slider
{
    if (slider.tag == 110) {
        
        CGPoint point = CGPointMake(slider.value, self.gradientLabel.startCenterOffset.y);
        self.gradientLabel.startCenterOffset = point;
        
    }else if (slider.tag == 111){
        
        CGPoint point = CGPointMake(self.gradientLabel.startCenterOffset.x, slider.value);
        self.gradientLabel.startCenterOffset = point;
        
    }else if (slider.tag == 112){
        
        CGPoint point = CGPointMake(slider.value, self.gradientLabel.endCenterOffset.y);
        self.gradientLabel.endCenterOffset = point;
        
    }else if (slider.tag == 113){
        
        CGPoint point = CGPointMake(self.gradientLabel.endCenterOffset.x, slider.value);
        self.gradientLabel.endCenterOffset = point;
        
    }else if (slider.tag == 114){
        
        self.gradientLabel.startRadius = slider.value;
        
        
    }else if (slider.tag == 115){
        
        self.gradientLabel.endRadius = slider.value;
        
    }
}



- (void)commonInit
{
    self.radialStartXSlider.maximumValue = self.radialEndXSlider.maximumValue = self.linearStartXSlider.maximumValue = self.linearEndXSlider.maximumValue = CGRectGetWidth(self.gradientLabel.frame);
    self.radialStartYSlider.maximumValue = self.radialEndYSlider.maximumValue = self.linearStartYSlider.maximumValue = self.linearEndYSlider.maximumValue = CGRectGetHeight(self.gradientLabel.frame);
    
    NSArray *linearSliders = @[self.linearStartXSlider, self.linearStartYSlider, self.linearEndXSlider, self.linearEndYSlider];
    
    NSUInteger linearTag = 100;

    for (UISlider *slider in linearSliders) {
        
        slider.tag = linearTag;
        linearTag ++;
        
    }
    
    NSArray *radialSliders = @[self.radialStartXSlider, self.radialStartYSlider, self.radialEndXSlider, self.radialEndYSlider, self.radialStartRadius, self.radialEndRadius];
    
    NSUInteger radialTag = 110;
    
    for (UISlider *slider in radialSliders) {
        
        slider.tag = radialTag;
        radialTag ++;
        
    }
    
    NSMutableArray *appendAll = [NSMutableArray array];
    [appendAll addObjectsFromArray:linearSliders];
    [appendAll addObjectsFromArray:radialSliders];
    
    
    for (UISlider *slider in appendAll) {
        
        [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
