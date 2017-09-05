//
//  CBJ3DLabel.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJ3DLabel.h"

@implementation CBJ3DLabel

- (void)drawTextInRect:(CGRect)rect {
    // Drawing code
    
    UIColor *shadowColor = [UIColor blackColor];
    NSUInteger depth = 8;
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = self.textAlignment;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    [attrs setObject:self.font forKey:NSFontAttributeName];
    [attrs setObject:self.textColor forKey:NSForegroundColorAttributeName];
    [attrs setObject:style forKey:NSParagraphStyleAttributeName];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSMutableArray *colorArrays = [[NSMutableArray alloc] initWithCapacity:depth];
    
    CGFloat *components = (CGFloat *)CGColorGetComponents(self.textColor.CGColor);
    CGFloat redComponent = 0;
    CGFloat greenComponent = 0;
    CGFloat blueComponent = 0;
    CGFloat alphaComponent = 1;
    
    if (CGColorGetNumberOfComponents(self.textColor.CGColor) == 2)
    {
        // 灰度空间
        redComponent = greenComponent = blueComponent = components[0];
        alphaComponent = components[1];
        
    }
    else if (CGColorGetNumberOfComponents(self.textColor.CGColor) == 4)
    {
        // 彩色RGBA空间
        redComponent = components[0];
        greenComponent = components[1];
        blueComponent = components[2];
        alphaComponent = components[3];
        
    }
    
    [colorArrays insertObject:self.textColor atIndex:0];
    
    CGFloat colorStep = floor(100/depth)/255.f;
    UIColor *newColor;
    
    UIColor *outlineColor;
    
    for (int i=0; i<depth; i++) {
        
        if (!outlineColor){
            
            CGFloat outlineRed = redComponent + 0.09f > 1.f ? 1.f : redComponent + 0.09f;
            CGFloat outlineGreen = greenComponent  + 0.09f > 1.f ? 1.f : greenComponent + 0.09f;
            CGFloat outlineBlue = blueComponent + 0.09f > 1.f ? 1.f : blueComponent + 0.09f;
            CGFloat outlineAlpha = alphaComponent + 0.09f > 1.f ? 1.f : alphaComponent + 0.09f;
            
            outlineColor = [UIColor colorWithRed:outlineRed green:outlineGreen blue:outlineBlue alpha:outlineAlpha];
            
        }
        
        
        if (redComponent > colorStep){
            redComponent-=colorStep;
        }
        
        if (greenComponent > colorStep) {
            greenComponent-=colorStep;
        }
        
        if (blueComponent > colorStep) {
            blueComponent-=colorStep;
        }
        
        newColor = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
        
        //we are inserting always at first index as we want this array of colors to be reversed (darkest color being the last)
        [colorArrays insertObject:newColor atIndex:0];
        
    }
    
    for (int i=0; i<depth; i++) {
        
        //change color
        newColor = (UIColor*)[colorArrays objectAtIndex:i];
        
        //draw the text
        CGContextSaveGState(context);
        
        CGContextSetShouldAntialias(context, YES);
        
        //draw outline if this is the last layer (front one)
        if (i+1==depth) {
            CGContextSetLineWidth(context, 1);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            
            CGContextSetTextDrawingMode(context, kCGTextStroke);
            [attrs setObject:outlineColor forKey:NSForegroundColorAttributeName];
            [self.text drawInRect:CGRectMake(rect.origin.x + i, rect.origin.y + i, rect.size.width, rect.size.height) withAttributes:attrs];
        }
        
        //draw filling
        [attrs setObject:newColor forKey:NSForegroundColorAttributeName];
        
        CGContextSetTextDrawingMode(context, kCGTextFill);
        
        //if this is the last layer (first one we draw), add the drop shadow too and the outline
        if (i==0) {
            CGContextSetShadowWithColor(context, CGSizeMake(-2, -2), 4.0f, shadowColor.CGColor);
        }
        else if (i+1!=depth){
            //add glow like blur
            CGContextSetShadowWithColor(context, CGSizeMake(-1, -1), 3.0f, newColor.CGColor);
        }
        
        [self.text drawInRect:CGRectMake(rect.origin.x + i, rect.origin.y + i, rect.size.width, rect.size.height) withAttributes:attrs];
        
        
        CGContextRestoreGState(context);
    }
    
}


@end
