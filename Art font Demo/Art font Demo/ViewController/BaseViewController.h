//
//  BaseViewController.h
//  Art font Demo
//
//  Created by 超八机 on 2017/9/5.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorControlView.h"

@interface BaseViewController : UIViewController <ColorControlViewDelegate>

@property (weak, nonatomic) ColorControlView *colorView;

@end
