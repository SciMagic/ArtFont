//
//  CBJGradientLabel.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJGradientLabel.h"

@implementation CBJGradientLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self commonInit];
        
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
    
        [self commonInit];
        
    }
    
    return self;
}

- (void)commonInit
{
    _startColor = [UIColor whiteColor];
    _endColor = [UIColor blueColor];
}

- (void)drawTextInRect:(CGRect)rect
{
    
    //for linear Gradient
    CGPoint startPoint = CGPointMake(0 + self.startPointOffset.x, 0 + self.startPointOffset.y);
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect) - self.endPointOffset.x, CGRectGetMaxY(rect) - self.endPointOffset.y);
    
    
    //for radia Gradient
    CGPoint startCenter = CGPointMake(0 + self.startCenterOffset.x, 0 + self.startCenterOffset.y);
    CGPoint endCenter = CGPointMake(CGRectGetMaxX(rect) - self.endCenterOffset.x, CGRectGetMaxY(rect) - self.endCenterOffset.y);
    
    
    
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
    [super drawTextInRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef mask = CGBitmapContextCreateImage(context);
    UIGraphicsEndImageContext();
    
    
    //Avoid cliping origin context,So begin a image context,and clip to it
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
    
    context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, CGRectGetHeight(rect)));
    CGContextClipToMask(context, rect, mask);
    
    NSArray *color = @[(id)self.startColor.CGColor,(id)self.endColor.CGColor];
    CGColorSpaceRef colorSpace  = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)color, NULL);
    
    switch (self.type) {
        case kGradientTypeLinear:
        {
            CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
        }
            break;
        case kGradientTypeRadial:
        {
            CGContextDrawRadialGradient(context, gradient, self.startCenterOffset, self.startRadius, self.endCenterOffset, self.endRadius,kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
        }
            break;
        default:
            break;
    }

    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    CFRelease(mask);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();//image context end here

    
    [image drawInRect:rect];
    
    if (self.showControlPoint) {
        
        if (self.type == kGradientTypeLinear) {
            
            UIBezierPath *pathStartPoint = [UIBezierPath bezierPathWithArcCenter:startPoint radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
            [pathStartPoint fill];
            
            UIBezierPath *pathEndPoint = [UIBezierPath bezierPathWithArcCenter:endPoint radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
            [pathEndPoint fill];
            
        }else{
            
            UIBezierPath *pathStartCenter = [UIBezierPath bezierPathWithArcCenter:startCenter radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
            [pathStartCenter fill];
            
            UIBezierPath *pathEndCenter = [UIBezierPath bezierPathWithArcCenter:endCenter radius:5 startAngle:0 endAngle:2*M_PI clockwise:YES];
            [pathEndCenter fill];
            
        }

        
    }
    
    
}


- (void)setType:(CBJGradientType)type
{
    _type = type;
    [self setNeedsDisplay];
}

- (void)setStartColor:(UIColor *)startColor
{
    _startColor = startColor;
    [self setNeedsDisplay];
}

- (void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;
    [self setNeedsDisplay];
}

- (void)setStartPointOffset:(CGPoint)startPointOffset
{
    _startPointOffset = startPointOffset;
    [self setNeedsDisplay];
}

- (void)setEndPointOffset:(CGPoint)endPointOffset
{
    _endPointOffset = endPointOffset;
    [self setNeedsDisplay];
}

- (void)setStartCenterOffset:(CGPoint)startCenterOffset
{
    _startCenterOffset = startCenterOffset;
    [self setNeedsDisplay];
}

- (void)setEndCenterOffset:(CGPoint)endCenterOffset
{
    _endCenterOffset = endCenterOffset;
    [self setNeedsDisplay];
}

- (void)setStartRadius:(CGFloat)startRadius
{
    _startRadius = startRadius;
    [self setNeedsDisplay];
}

- (void)setEndRadius:(CGFloat)endRadius
{
    _endRadius = endRadius;
    [self setNeedsDisplay];
}

@end
