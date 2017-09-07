//
//  HollowLabelViewController.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "HollowLabelViewController.h"
#import "CBJHollowLabel.h"

@interface HollowLabelViewController ()

@property (weak, nonatomic) CBJHollowLabel *hollowLabel;

@end

@implementation HollowLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.colorView addSegmentControl:@[@"maskColor"]];
    
    CBJHollowLabel *hollowLabel = [[CBJHollowLabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 100)];
    hollowLabel.textAlignment = NSTextAlignmentCenter;
    hollowLabel.font = [UIFont systemFontOfSize:60.f];
    hollowLabel.text = @"HOLLOW";
    self.hollowLabel = hollowLabel;
    
    [self.view addSubview:hollowLabel];
    
}

- (void)didSelectColor:(UIColor *)color forKey:(NSString *)key
{
    if ([key isEqualToString:@"maskColor"]) {
        
        self.hollowLabel.maskColor = color;
        
    }
    [self updateInfo];
}

- (NSString *)getStyleString
{
    NSString *maskColorStr = [self hexStringFromColor:self.hollowLabel.maskColor];
    NSString *style = [NSString stringWithFormat:@"HollowLabel \n MaskColor: %@", maskColorStr];
    return style;
    
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
