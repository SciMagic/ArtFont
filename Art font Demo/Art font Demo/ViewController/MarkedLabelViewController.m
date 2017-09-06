//
//  MarkedLabelViewController.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "MarkedLabelViewController.h"
#import "CBJMarkedLabel.h"
@interface MarkedLabelViewController ()
@property (weak, nonatomic) IBOutlet UISlider *maskAlphaSlider;
@property (weak, nonatomic) IBOutlet UISlider *spaceRangeSlider;
@property (weak, nonatomic) CBJMarkedLabel *markedLabel;
@end

@implementation MarkedLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CBJMarkedLabel *markedLabel = [[CBJMarkedLabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 100)];
    markedLabel.textAlignment = NSTextAlignmentCenter;
    markedLabel.font = [UIFont systemFontOfSize:30.f];
    markedLabel.text = @"MARKEDTEXT";
    markedLabel.strokeTexture = [UIImage imageNamed:@"brush@2x.png"];
    self.markedLabel = markedLabel;
    
    [self.view addSubview:self.markedLabel];
    
    [self.colorView addSegmentControl:@[@"textureColor",@"textColor"]];
    
    self.maskAlphaSlider.value = self.markedLabel.maskAlpha;
    self.spaceRangeSlider.value = self.markedLabel.spaceRange;
    
    [self commonInit];
    
}

- (void)commonInit
{
    [self.maskAlphaSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.spaceRangeSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)reverseBtnClicked:(id)sender {
    
    self.markedLabel.maskTop = !self.markedLabel.maskTop;
    
}

- (void)sliderValueChanged:(UISlider *)slider
{
    if(slider == self.maskAlphaSlider) {
        
        self.markedLabel.maskAlpha = slider.value;
        
    }else{
        
        self.markedLabel.spaceRange = (NSUInteger)(slider.value + 0.5);
        
    }
}

- (void)didSelectColor:(UIColor *)color forKey:(NSString *)key
{
    if ([key isEqualToString:@"textureColor"]) {
        
        self.markedLabel.textureColor = color;
        
    }else{
        
        self.markedLabel.textColor = color;
        
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
