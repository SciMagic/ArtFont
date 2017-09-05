//
//  CBJMarkedLabel.h
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBJMarkedLabel : UILabel

@property (assign, nonatomic) BOOL maskTop;
@property (assign, nonatomic) CGFloat maskAlpha;
@property (strong, nonatomic) UIImage *strokeTexture;
@property (strong, nonatomic) UIColor *textureColor;

@end
