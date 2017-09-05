//
//  CBJGradientLabel.h
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CBJGradientType) {
    kGradientTypeLinear,
    kGradientTypeRadial
};


@interface CBJGradientLabel : UILabel

@property (assign, nonatomic) CBJGradientType type;
@property (strong, nonatomic) UIColor *startColor;
@property (strong, nonatomic) UIColor *endColor;

//for linear Gradient
@property (assign, nonatomic) CGPoint startPointOffset;  //startPoint relative to (0 + sp.tx, 0 + sp.ty)
@property (assign, nonatomic) CGPoint endPointOffset;    //endPoint relative  to (contextRectMaxX - ep.tx, contextRectMaxY - ep.ty)

//for radia Gradient
@property (assign, nonatomic) CGPoint startCenterOffset; //same as startPointOffset
@property (assign, nonatomic) CGFloat startRadius;

@property (assign, nonatomic) CGPoint endCenterOffset; //same as endPointOffset
@property (assign, nonatomic) CGFloat endRadius;


@property (assign, nonatomic) BOOL showControlPoint;
@end
