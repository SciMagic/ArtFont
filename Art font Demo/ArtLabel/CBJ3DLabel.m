//
//  CBJ3DLabel.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/2.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJ3DLabel.h"

@implementation CBJ3DLabel


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
    _subjectColor = [UIColor colorWithRed:(200/255.f) green:(200/255.f) blue:(200/255.f) alpha:1];
    _drawDepth = 8;
    _bottomBlurColor = [UIColor blackColor];
    _orientation = kOrientationBottomRight;
}


- (void)drawTextInRect:(CGRect)rect {
    
    NSAssert(self.drawDepth > 0, @"divisor must greater than zero");
    
    //Get Color componet
    CGFloat redComponent = 0;
    CGFloat greenComponent = 0;
    CGFloat blueComponent = 0;
    CGFloat alphaComponent = 1;
    [self getColorComponentRed:&redComponent Green:&greenComponent Blue:&blueComponent Alpha:&alphaComponent];
    
    //General depthColor
    NSArray *colors = [self generalColorsWithRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSMutableDictionary *attrs = [self getTextAttributes];
    
    for (int i=0; i<self.drawDepth; i++) {
        
        //>>>>>
        CGContextSaveGState(context);
        
        CGContextSetShouldAntialias(context, YES);
        
        //X: + Rihgt , - Left
        NSInteger dirX = (1&self.orientation) == 1 ? 1 : -1; //01 & (00,01,10,11) => (00,01,00,01)
        //Y: + Bottom, - Top
        NSInteger dirY = (2&self.orientation) == 2 ? 1 : -1; //10 & (00,01,10,11) => (00,00,10,10)
        
        //draw outline for the top layer (front one)
        if (i+1==self.drawDepth) {
            CGContextSetLineWidth(context, 1);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            CGContextSetTextDrawingMode(context, kCGTextStroke);
            [attrs setObject:[self getTopLayerOutLineColor:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent] forKey:NSForegroundColorAttributeName];
            
            
            [self.text drawInRect:CGRectMake(rect.origin.x + i*dirX, rect.origin.y + i*dirY, rect.size.width, rect.size.height) withAttributes:attrs];
        }
        
        //get depth color
        UIColor *depthColor = (UIColor*)[colors objectAtIndex:i];
        
        [attrs setObject:depthColor forKey:NSForegroundColorAttributeName];
        
        CGContextSetTextDrawingMode(context, kCGTextFill);
        
        //add showdow blur for bottom layer
        if (i==0) {
            CGContextSetShadowWithColor(context, CGSizeMake(-2*dirX, -2*dirY), 4.0f, self.bottomBlurColor.CGColor);
            
        }else if (i+1!=self.drawDepth){
            
            //add blur that smooths the color
            CGContextSetShadowWithColor(context, CGSizeMake(-1*dirX, -1*dirY), 3.0f, depthColor.CGColor);
        }
        
        [self.text drawInRect:CGRectMake(rect.origin.x + i*dirX, rect.origin.y + i*dirY, rect.size.width, rect.size.height) withAttributes:attrs];
        
        //>>>>>>>
        CGContextRestoreGState(context);
    }
    
}


//为每个深度平滑的生成一个颜色，让字体看起来有一定透视感
- (NSArray *)generalColorsWithRed:(CGFloat)redComponent green:(CGFloat)greenComponent blue:(CGFloat)blueComponent alpha:(CGFloat)alphaComponent
{
    NSMutableArray *colorArrays = [[NSMutableArray alloc] initWithCapacity:self.drawDepth];
    [colorArrays insertObject:self.subjectColor atIndex:0];
    CGFloat colorStep = floor(100/self.drawDepth)/255.f;
    
    UIColor *newColor;
    UIColor *outlineColor;
    
    for (int i=0; i<self.drawDepth; i++) {
        
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
        
        //drak color at bottom
        [colorArrays insertObject:newColor atIndex:0];
        
    }
    
    return colorArrays;
}

//生成顶层描边颜色，给顶层添加一定的锐化效果，看起来棱角分明，这是调出来的效果，别疑惑为什么是+0.09
- (UIColor *)getTopLayerOutLineColor:(CGFloat)redComponent green:(CGFloat)greenComponent blue:(CGFloat)blueComponent alpha:(CGFloat)alphaComponent
{
    
    CGFloat outlineRed = redComponent + 0.09f > 1.f ? 1.f : redComponent + 0.09f;
    CGFloat outlineGreen = greenComponent  + 0.09f > 1.f ? 1.f : greenComponent + 0.09f;
    CGFloat outlineBlue = blueComponent + 0.09f > 1.f ? 1.f : blueComponent + 0.09f;
    CGFloat outlineAlpha = alphaComponent + 0.09f > 1.f ? 1.f : alphaComponent + 0.09f;
    
    UIColor *outlineColor = [UIColor colorWithRed:outlineRed green:outlineGreen blue:outlineBlue alpha:outlineAlpha];
    
    return outlineColor;
    
}


//获取颜色分量，直接使用[UIColor whiteColor]等生成的是灰度空间色彩，components的值是不一样的
- (void)getColorComponentRed:(CGFloat *)redComponent Green:(CGFloat *)greenComponent Blue:(CGFloat *)blueComponent Alpha:(CGFloat *)alphaComponent
{
    CGFloat *components = (CGFloat *)CGColorGetComponents(self.subjectColor.CGColor);
    
    if (CGColorGetNumberOfComponents(self.subjectColor.CGColor) == 2)
    {
        // 灰度空间
        *redComponent = *greenComponent = *blueComponent = components[0];
        *alphaComponent = components[1];
        
    }
    else if (CGColorGetNumberOfComponents(self.subjectColor.CGColor) == 4)
    {
        // 彩色RGBA空间
        *redComponent = components[0];
        *greenComponent = components[1];
        *blueComponent = components[2];
        *alphaComponent = components[3];
        
    }

}

- (NSMutableDictionary *)getTextAttributes
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = self.textAlignment;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    [attrs setObject:self.font forKey:NSFontAttributeName];
    [attrs setObject:self.subjectColor forKey:NSForegroundColorAttributeName];
    [attrs setObject:style forKey:NSParagraphStyleAttributeName];
    return [attrs mutableCopy];
}


- (void)setSubjectColor:(UIColor *)subjectColor
{
    _subjectColor = subjectColor;
    [self setNeedsDisplay];
}

- (void)setDrawDepth:(NSUInteger)drawDepth
{
    _drawDepth = drawDepth;
    [self setNeedsDisplay];
}

- (void)setBottomBlurColor:(UIColor *)bottomBlurColor
{
    _bottomBlurColor = bottomBlurColor;
    [self setNeedsDisplay];
}

- (void)setOrientation:(CBJ3DLabelOrientation)orientation
{
    _orientation = orientation;
    [self setNeedsDisplay];
}
@end
