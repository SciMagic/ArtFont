//
//  CBJPaletteView.m
//  Palette
//
//  Created by 超八机 on 2017/7/30.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJPaletteView.h"

@interface CBJPaletteView ()

@property (weak, nonatomic) UIImageView *colorView;

@end

@implementation CBJPaletteView

- (instancetype)initWithPaletteType:(PaletteType)type
{
    return [self initWithPaletteType:type withFrame:CGRectZero];
}

- (instancetype)initWithPaletteType:(PaletteType)type withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUpColorView:type];
        [self setUpGestureRecognizer];
        
    }
    
    return self;
}

- (instancetype)initWithPaletteImage:(UIImage *)image withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUpColorViewWithImage:image];
        [self setUpGestureRecognizer];
    }
    
    return self;
    
}

- (instancetype)init
{
    return [self initWithPaletteType:PaletteStrip];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithPaletteType:PaletteStrip withFrame:frame];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithPaletteType:PaletteStrip];
}

#pragma mark ---Private Method---
- (void)setUpColorViewWithImage:(UIImage *)colorImg
{
    UIImageView *colorView = [[UIImageView alloc] initWithImage:colorImg];
    colorView.frame = self.bounds;
    colorView.userInteractionEnabled = YES;
    colorView.contentMode = UIViewContentModeScaleAspectFit;
    [colorView setImage:colorImg];
    self.colorView = colorView;
    [self addSubview:colorView];
}

- (void)setUpColorView:(PaletteType)type
{
    //get color img name
    NSString *imgSrcName = @"strip";
    
    switch (type) {
        case PaletteStrip:
            imgSrcName = @"strip";
            break;
        case PaletteCircle:
            imgSrcName = @"circle";
            break;
        case PaletteHexagon:
            imgSrcName = @"hexagon";
            break;
        default:
            break;
    }
    
    //add color imageView to view
    self.backgroundColor = [UIColor clearColor];
    UIImage *colorImg = [UIImage imageNamed:imgSrcName];
    [self setUpColorViewWithImage:colorImg];
    
}

- (void)setUpGestureRecognizer
{
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.colorView addGestureRecognizer:tapGR];
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    panGR.maximumNumberOfTouches = 1;
    [self.colorView addGestureRecognizer:panGR];
}

#pragma mark ---UIGestureRecognizer---
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGR
{
    CGPoint tapPoint = [tapGR locationInView:self.colorView];
    
    UIColor *color = [self colorAtPixel:tapPoint];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectColor:selectedColor:)]) {
        
        [self.delegate didSelectColor:self selectedColor:color];
        
    }
    
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGR
{
    CGPoint panPoint = [panGR locationInView:self.colorView];
    
    UIColor *color = [self colorAtPixel:panPoint];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectColor:selectedColor:)]) {
        
        [self.delegate didSelectColor:self selectedColor:color];
        
    }
    
}

#pragma mark ---Pixel color handle---
- (UIColor *)colorAtPixel:(CGPoint)point {
    
    UIImage *colorImg = self.colorView.image;
    
    if (!CGRectContainsPoint(self.colorView.bounds, point))
    {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    
    CGImageRef cgImage = colorImg.CGImage;
    NSUInteger width = self.colorView.bounds.size.width;//colorImg.size.width;
    NSUInteger height = self.colorView.bounds.size.height; //colorImg.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast |     kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
