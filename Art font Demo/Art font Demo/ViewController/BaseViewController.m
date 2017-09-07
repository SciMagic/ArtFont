//
//  BaseViewController.m
//  Art font Demo
//
//  Created by QD-ZC on 2017/9/5.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ColorControlView *colorView = [[ColorControlView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 300, CGRectGetWidth(self.view.frame), 300)];
    //[colorView addSegmentControl:[NSArray arrayWithObjects:@"边框颜色", @"字体颜色",nil]];
    colorView.delegate = self;
    self.colorView = colorView;
    [self.view addSubview:colorView];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)updateInfo
{
    [self.colorView updateInfo];
}

- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectColor:(UIColor *)color forKey:(NSString *)key
{
    
}

- (NSString *)getStyleString
{
    return @"";
    
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
