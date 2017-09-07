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
    _glowColor = [UIColor redColor];
    _glowSize = 10.f;
}

- (void)setGlowSize:(CGFloat)glowSize
{
    _glowSize = glowSize;
    [self setNeedsDisplay];
}

- (void)setGlowColor:(UIColor *)glowColor
{
    _glowColor = glowColor;
    [self setNeedsDisplay];
}

- (void)drawTextInRect:(CGRect)rect
{
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShadowWithColor(context, CGSizeZero, self.glowSize, self.glowColor.CGColor);
    
    [super drawTextInRect:rect];
    
    CGContextSetLineWidth(context, 0.2);
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    
    [super drawTextInRect:rect];
    
    
}

@end
