//
//  CBJGlowLabel.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJGlowLabel.h"

@implementation CBJGlowLabel

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
    self.textColor = [UIColor whiteColor];
    self.glowColor = [UIColor redColor];
    self.glowSize = 10.f;
}

- (void)drawTextInRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShadow(context, CGSizeZero, self.glowSize);
    
    CGContextSetShadowWithColor(context, CGSizeZero, self.glowSize, self.glowColor.CGColor);
    
    [super drawTextInRect:rect];
    
    CGContextSetLineWidth(context, 0.2);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    
    self.textColor = self.glowColor;
    
    [super drawTextInRect:rect];
    
    
}

@end
