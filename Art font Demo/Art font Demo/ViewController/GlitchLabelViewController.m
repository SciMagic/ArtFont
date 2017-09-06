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
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view.
    CBJGlitchLabel *glitchLabel = [[CBJGlitchLabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 100)];
    glitchLabel.textAlignment = NSTextAlignmentCenter;
    glitchLabel.font = [UIFont systemFontOfSize:60.f];
    glitchLabel.text = @"GLITCH";
    self.glitchLabel = glitchLabel;
    [self.view addSubview:glitchLabel];
    
    [self.colorView addSegmentControl:@[@"leftColor",@"centerColor",@"rightColor"]];
}

- (void)didSelectColor:(UIColor *)color forKey:(NSString *)key
{
    if ([key isEqualToString:@"leftColor"]) {
        
        self.glitchLabel.leftColor = color;
        
    }else if ([key isEqualToString:@"rightColor"]){
        
        self.glitchLabel.rightColor = color;
        
    }else{
        
        self.glitchLabel.centerColor = color;
        
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
