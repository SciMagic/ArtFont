//
//  GlitchLabelViewController.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/6.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "GlitchLabelViewController.h"
#import "CBJGlitchLabel.h"

@interface GlitchLabelViewController ()

@property (weak, nonatomic) CBJGlitchLabel *glitchLabel;

@end

@implementation GlitchLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view.
    CBJGlitchLabel *glitchLabel = [[CBJGlitchLabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 100)];
    glitchLabel.textAlignment = NSTextAlignmentCenter;
    glitchLabel.font = [UIFont fontWithName:@"Arial-ItalicMT" size:60.f];
    glitchLabel.text = @"GLITCH";
    self.glitchLabel = glitchLabel;
    [self.view addSubview:glitchLabel];
    
    [self.colorView addSegmentControl:@[@"bottomColor",@"middleColor",@"topColor"]];
}

- (void)didSelectColor:(UIColor *)color forKey:(NSString *)key
{
    if ([key isEqualToString:@"bottomColor"]) {
        
        self.glitchLabel.bottomColor = [self thinColor:color alpha:0.7f];
        
    }else if ([key isEqualToString:@"middleColor"]){
        
        self.glitchLabel.middleColor = [self thinColor:color alpha:0.7f];
        
    }else{
        
        self.glitchLabel.topColor = [self thinColor:color alpha:0.7f];
        
    }
    [self updateInfo];
}

- (NSString *)getStyleString
{
    
    NSString *bottomColorStr = [self hexStringFromColor:self.glitchLabel.bottomColor];
    NSString *middleColorStr = [self hexStringFromColor:self.glitchLabel.middleColor];
    NSString *topColorStr = [self hexStringFromColor:self.glitchLabel.topColor];
    
    NSString *style = [NSString stringWithFormat:@"GlitchLabel \n BottomColor: %@ \n MiddleColor: %@ \n TopColor: %@", bottomColorStr, middleColorStr, topColorStr];
    
    return style;
}


- (UIColor *)thinColor:(UIColor *)originColor alpha:(CGFloat)talpha
{
    CGFloat red,green,blue,alpha = 0.0;
    [originColor getRed:&red green:&green blue:&blue alpha:&alpha];
    UIColor *thinColor = [UIColor colorWithRed:red green:green blue:blue alpha:talpha];
    return thinColor;
}
- (IBAction)redrawRandomLineClicked:(id)sender {
    
    [self.glitchLabel redrawRandomLine];
    
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
