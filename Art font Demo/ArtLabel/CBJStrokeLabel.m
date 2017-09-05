//
//  CBJStrokeLabel.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJStrokeLabel.h"

@implementation CBJStrokeLabel

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
    self.outlineColor = [UIColor whiteColor];
    self.outlineWidth = 0.f;
}

- (void)drawTextInRect:(CGRect)rect
{
    UIColor *textColor = self.textColor;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.outlineWidth > 0.f) {
        
        CGContextSetLineWidth(context, self.outlineWidth);
        
        CGContextSetLineJoin(context, kCGLineJoinRound);
        
        CGContextSetTextDrawingMode(context, kCGTextStroke);
        
        self.textColor = self.outlineColor;
        
        [super drawTextInRect:rect];
        
    }
    
    self.textColor = textColor;
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    
    [super drawTextInRect:rect];
}


@end
