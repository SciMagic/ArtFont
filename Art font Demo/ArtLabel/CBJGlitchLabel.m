//
//  CBJGlitchLabel.m
//  Art font Demo
//
//  Created by 超八机 on 2017/9/5.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJGlitchLabel.h"

@interface CBJGlitchLabel ()

@property (strong, nonatomic) NSArray *randomLineRects;

@end

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
    _bottomColor = [UIColor colorWithRed:189.f/255.f green:17.f/255.f blue:185.f/255.f alpha:1.f];
    _middleColor = [UIColor colorWithRed:43.f/255.f green:205.f/255.f blue:199.f/255.f alpha:1.f];
    _topColor = [UIColor colorWithWhite:1.f alpha:1.f];
    _bottomOffset = CGPointMake(-2, 0);
    _middleOffset = CGPointMake(2, 0);
    _sliceRects = [self generalTestRects];
    
}

- (NSArray<NSValue *> *)generalTestRects
{
    
    NSValue *rect1 = [NSValue valueWithCGRect:CGRectMake(0, 0.25, 1, 0.05)];
    NSValue *rect2 = [NSValue valueWithCGRect:CGRectMake(0, 0.35, 1, 0.05)];
    NSValue *rect3 = [NSValue valueWithCGRect:CGRectMake(0, 0.45, 1, 0.02)];
    NSValue *rect4 = [NSValue valueWithCGRect:CGRectMake(0, 0.55, 1, 0.05)];
    NSValue *rect5 = [NSValue valueWithCGRect:CGRectMake(0, 0.65, 1, 0.03)];
    
    return @[rect1, rect2, rect3, rect4, rect5];
    
}


- (void)drawTextInRect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawContentImage:rect];
    
    CGImageRef contentImage = CGBitmapContextCreateImage(context);
    
    UIGraphicsEndImageContext();
    
    context = UIGraphicsGetCurrentContext();

    [self drawContentImage:rect];
    
    if (!self.sliceRects) {
        
        CGImageRelease(contentImage); contentImage = NULL;
        return;
        
    }
    
    CGFloat IMGWidth = CGImageGetWidth(contentImage);
    CGFloat IMGHeight = CGImageGetHeight(contentImage);
    
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    
    NSUInteger i = 1;
    
    for (NSValue *rectValue in self.sliceRects) {
        
        CGRect percentageRect = [rectValue CGRectValue];
        
        CGRect imageSlice = [self glitchConvertRect:percentageRect fromSize:CGSizeMake(IMGWidth, IMGHeight)];
        
        CGImageRef sliceRef = CGImageCreateWithImageInRect(contentImage, imageSlice);
        
        CGRect contentSlice = [self glitchConvertRect:percentageRect fromSize:rect.size];
        
        
        CGContextClearRect(context, contentSlice);
        
        CGContextRef bitMapRef = CGBitmapContextCreate(NULL, CGImageGetWidth(sliceRef), CGImageGetHeight(sliceRef), CGImageGetBitsPerComponent(sliceRef), CGImageGetBytesPerRow(sliceRef), CGImageGetColorSpace(sliceRef), CGImageGetBitmapInfo(sliceRef));
        

        CGContextConcatCTM(bitMapRef, CGAffineTransformMake(1, 0, 0, -1, 0, CGImageGetHeight(sliceRef)));
        
        CGContextDrawImage(bitMapRef, CGRectMake(0, 0, CGImageGetWidth(sliceRef), CGImageGetHeight(sliceRef)), sliceRef);
        

        
        CGImageRef rotateRef = CGBitmapContextCreateImage(bitMapRef);
        
        CGImageRelease(sliceRef); sliceRef = NULL;
        CGContextRelease(bitMapRef); bitMapRef = NULL;
        
        CGRect translatedRect = [self translateRect:contentSlice count:i];
        
        CGContextDrawImage(context, translatedRect, rotateRef);
        i++;
        
        CGImageRelease(rotateRef);
        bitMapRef = NULL;
        
        if (self.showSlice) {
            
            CGContextFillRect(context, contentSlice);
            
        }
        
    }
    
    if (self.randomLineRects) {
        
        [self drawRandomLine:self.randomLineRects contextRect:rect];
        
    }else{
        
        self.randomLineRects = [self generalRandomLine:rect];
        [self drawRandomLine:self.randomLineRects contextRect:rect];
    }    
    
    CGImageRelease(contentImage); contentImage = NULL;

}

- (NSArray *)generalRandomLine:(CGRect)rect
{
    //1.general random rect, height should be small
    //2.if random rect overlap on other's, discard it
    //3.control the try step
    CGSize textSize = [self getTextSize];
    CGFloat drawMinY = (CGRectGetHeight(rect) - textSize.height)/2.f;
    CGFloat drawMaxY = CGRectGetHeight(rect) - drawMinY;
    
    
    NSMutableArray *rects = [NSMutableArray array];
    
    NSUInteger tryStep = 25;
    for (NSUInteger i = 0; i < tryStep; i++) {
        
        CGFloat x = (((CGFloat) rand() / RAND_MAX) * CGRectGetWidth(rect));
        CGFloat y = (((CGFloat) rand() / RAND_MAX) * CGRectGetHeight(rect));
        
        CGFloat width = (((CGFloat) rand() / RAND_MAX) * CGRectGetWidth(rect)/8.f);
        CGFloat height = (((CGFloat) rand() / RAND_MAX) * 3);
        
        CGRect randomRect = CGRectMake(x, y, width, height);
        
        CGFloat minY = CGRectGetMinY(randomRect);
        
        
        //draw line arround text
        if (minY < drawMinY || minY > drawMaxY) {
            
            continue;
            
        }
        
        //discard overlap line
        BOOL overlaped = NO;
        for (NSValue *rectValue in rects) {
            
            if (CGRectIntersectsRect([rectValue CGRectValue], randomRect)) {
                
                overlaped = YES;
                break;
                
            }
        }
        
        if (overlaped) {
            
            continue;
        }
        
        [rects addObject:[NSValue valueWithCGRect:randomRect]];
    }
    
    return [rects copy];
}

- (void)drawRandomLine:(NSArray *)randomLineRects contextRect:(CGRect)rect
{
    CGFloat rectMidX = CGRectGetMidX(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *fillColor = self.topColor;
    for (NSValue *randomRectValue in randomLineRects) {
        
        CGRect randomRect = [randomRectValue CGRectValue];
        CGFloat minX = CGRectGetMinX(randomRect);
        
        if (minX < rectMidX) {
            
            fillColor = self.bottomColor;
            
        }else{
            
            fillColor = self.middleColor;
            
        }
        
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillRect(context, randomRect);
        
    }
    
}

- (CGSize)getTextSize
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = self.textAlignment;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    [attrs setObject:self.font forKey:NSFontAttributeName];
    [attrs setObject:self.textColor forKey:NSForegroundColorAttributeName];
    [attrs setObject:style forKey:NSParagraphStyleAttributeName];
    
    CGSize size = [self.text sizeWithAttributes:attrs];
    return size;
}

- (CGRect)translateRect:(CGRect)rect count:(NSUInteger)i
{
    CGRect translatedRect = rect;
    CGFloat translateValue = [self getTranslateValue:i];
    
    translatedRect = CGRectOffset(rect, translateValue, 0);
    
    return translatedRect;
}

//if function return totally random value, it would be hard to adjust style
- (CGFloat)getTranslateValue:(NSUInteger)i
{
    if (i % 5 == 0) {
        
        return -2.f;
        
    }else if(i % 3 == 0){
        
        return 2.f;
        
    }else if (i % 2 == 0){
        
        return 1.f;
        
    }else{
    
        return -3.f;
        
    }

}

- (CGRect)glitchConvertRect:(CGRect)percentageRect fromSize:(CGSize)size
{
    
    CGFloat covertedX = CGRectGetMinX(percentageRect) * size.width;
    CGFloat covertedY = CGRectGetMinY(percentageRect) * size.height;
    CGFloat covertedWidth = CGRectGetWidth(percentageRect) * size.width;
    CGFloat covertedHeight = CGRectGetHeight(percentageRect) * size.height;
    
    CGRect covertedRect = CGRectMake(covertedX, covertedY, covertedWidth, covertedHeight);
    
    return covertedRect;
}

- (void)drawContentImage:(CGRect)rect
{
    CGRect bottomRect = CGRectMake(rect.origin.x + self.bottomOffset.x, rect.origin.y + self.bottomOffset.y, rect.size.width, rect.size.height);
    CGRect middleRect = CGRectMake(rect.origin.x + self.middleOffset.x, rect.origin.y + self.middleOffset.y, rect.size.width, rect.size.height);
    
    self.textColor = self.bottomColor;
    [super drawTextInRect:bottomRect];
    
    self.textColor = self.middleColor;
    [super drawTextInRect:middleRect];
    
    self.textColor = self.topColor;
    [super drawTextInRect:rect];
}

- (void)redrawRandomLine
{
    _randomLineRects = nil;
    [self setNeedsDisplay];
}

- (void)setTopColor:(UIColor *)topColor
{
    _topColor = topColor;
    [self setNeedsDisplay];
}

- (void)setMiddleColor:(UIColor *)middleColor
{
    _middleColor = middleColor;
    [self setNeedsDisplay];
}

- (void)setBottomColor:(UIColor *)bottomColor
{
    _bottomColor = bottomColor;
    [self setNeedsDisplay];
}

@end
