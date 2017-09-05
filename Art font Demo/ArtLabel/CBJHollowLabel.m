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
        
        self.opaque = NO;
        [super setBackgroundColor:[UIColor clearColor]];
        [super setTextColor:[UIColor whiteColor]];
        
    }
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.opaque = NO;
        [super setBackgroundColor:[UIColor clearColor]];
        [super setTextColor:[UIColor whiteColor]];
        
    }
    
    return self;
    
}


- (void)drawTextInRect:(CGRect)rect
{

    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0);
    [super drawTextInRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIGraphicsEndImageContext();
    
    
    context = UIGraphicsGetCurrentContext();
    
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, CGRectGetHeight(rect)));
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(image), CGImageGetHeight(image), CGImageGetBitsPerComponent(image), CGImageGetBitsPerPixel(image), CGImageGetBytesPerRow(image), CGImageGetDataProvider(image), CGImageGetDecode(image), CGImageGetShouldInterpolate(image));
    
    CFRelease(image);
    image = NULL;
    
    CGContextClearRect(context, rect);
    CGContextClipToMask(context, rect, mask);

    CFRelease(mask);
    mask = NULL;
    
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    
    
}

- (void) RS_drawBackgroundInRect:(CGRect)rect
{
    // this is where you do whatever fancy drawing you want to do!

}

@end
