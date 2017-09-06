//
//  CBJ3DLabel.h
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CBJ3DLabelOrientation) {
    kOrientationTopLeft = 0,
    kOrientationTopRight = 1,
    kOrientationBottomLeft = 2,
    kOrientationBottomRight = 3
};


@interface CBJ3DLabel : UILabel

//主题色彩
@property(strong, nonatomic) UIColor *subjectColor;

//绘制深度，切片数
@property(assign, nonatomic) NSUInteger drawDepth;

//底部散射阴影
@property(strong, nonatomic) UIColor *bottomBlurColor;

//字体朝向
@property(assign, nonatomic) CBJ3DLabelOrientation orientation;
@end
