//
//  CBJHollowLabel.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJHollowLabel.h"

@implementation CBJHollowLabel

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
    self.opaque = NO;
    _maskColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
}


- (void)setMaskColor:(UIColor *)maskColor
{
    _maskColor = maskColor;
    [self setNeedsDisplay];
}

- (void)drawTextInRect:(CGRect)rect
{
    
    self.textColor = [UIColor whiteColor];

    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
    [super drawTextInRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIGraphicsEndImageContext();
    
    context = UIGraphicsGetCurrentContext();
    
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, CGRectGetHeight(rect)));
    
    //image被当成灰度图处理，黑色标示alpha为0,白色标示alpha为1，上面将textColor设置为白色，为的就是将文字作为mask
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(image), CGImageGetHeight(image), CGImageGetBitsPerComponent(image), CGImageGetBitsPerPixel(image), CGImageGetBytesPerRow(image), CGImageGetDataProvider(image), CGImageGetDecode(image), CGImageGetShouldInterpolate(image));
    
    CFRelease(image);
    image = NULL;
    
    CGContextClearRect(context, rect);
    CGContextClipToMask(context, rect, mask);

    CFRelease(mask);
    mask = NULL;
    
    [self.maskColor set];
    CGContextFillRect(context, rect);
    
    
}

@end
