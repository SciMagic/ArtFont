//
//  CBJGlitchLabel.h
//  Art font Demo
//
//  Created by 超八机 on 2017/9/5.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBJGlitchLabel : UILabel

@property (strong, nonatomic) UIColor *topColor;
@property (strong, nonatomic) UIColor *middleColor;
@property (strong, nonatomic) UIColor *bottomColor;

@property (assign, nonatomic) CGPoint middleOffset;
@property (assign, nonatomic) CGPoint bottomOffset;

@property (copy, nonatomic) NSArray<NSValue *> *sliceRects;
@property (assign, nonatomic) BOOL showSlice;

- (void)redrawRandomLine;

@end
