//
//  CBJGlitchLabel.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/5.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJGlitchLabel.h"

@implementation CBJGlitchLabel

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
    _leftColor = [UIColor colorWithRed:189.f/255.f green:17.f/255.f blue:185.f/255.f alpha:1.f];
    _rightColor = [UIColor colorWithRed:43.f/255.f green:205.f/255.f blue:199.f/255.f alpha:1.f];
    _centerColor = [UIColor whiteColor];
}

- (void)drawTextInRect:(CGRect)rect
{
    [self drawContentImage:rect];
}

- (void)drawContentImage:(CGRect)rect
{
    CGRect leftRect = CGRectMake(rect.origin.x - 2, rect.origin.y, rect.size.width, rect.size.height);
    CGRect rightRect = CGRectMake(rect.origin.x + 2, rect.origin.y, rect.size.width, rect.size.height);
    
    self.textColor = self.leftColor;
    [super drawTextInRect:leftRect];
    
    self.textColor = self.centerColor;
    [super drawTextInRect:rect];
    
    self.textColor = self.rightColor;
    [super drawTextInRect:rightRect];
}


- (void)setLeftColor:(UIColor *)leftColor
{
    _leftColor = leftColor;
    [self setNeedsDisplay];
}

- (void)setRightColor:(UIColor *)rightColor
{
    _rightColor = rightColor;
    [self setNeedsDisplay];
}

- (void)setCenterColor:(UIColor *)centerColor
{
    _centerColor = centerColor;
    [self setNeedsDisplay];
}

@end
