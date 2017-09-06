//
//  UIImage+TintColor.m
//  FontTest
//
//  Created by QD on 2017/8/24.
//  Copyright © 2017年 QD. All rights reserved.
//

#import "UIImage+TintColor.h"

typedef NS_ENUM(NSInteger, Pixel) {
    Alpha = 0,
    Blue = 1,
    Green = 2,
    Red = 3,
};

@implementation UIImage (TintColor)
- (UIImage *)textureWithTintColor:(UIColor *)color {
    
    CGFloat red, green, blue, alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    uint8_t blendRed = ( (1 - alpha) + alpha * red) * 255;
    uint8_t blendGreen = ( (1 - alpha) + alpha * green ) * 255;
    uint8_t blendBlue = ( (1 - alpha) + alpha * blue ) * 255;
    
    CGSize size = self.size;
    int width = size.width;
    int height = size.height;
    
    uint32_t *pixels = (uint32_t *)malloc(width * height * sizeof(uint32_t));
    
    memset(pixels, 0, width * height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, width, height), self.CGImage);
    
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            uint8_t pixelRed = rgbaPixel[Red];
            uint8_t dgreen = rgbaPixel[Green] / 255.0 * blendGreen;
            uint8_t dblue = rgbaPixel[Blue] / 255.0 * blendBlue;
            uint8_t dred = rgbaPixel[Red] / 255.0 * blendRed;
            rgbaPixel[Red] = dred;
            rgbaPixel[Green] = dgreen;
            rgbaPixel[Blue] = dblue;
            rgbaPixel[Alpha] = pixelRed;
        }
    }
    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    UIImage *texture = [UIImage imageWithCGImage: cgImage];
    CGImageRelease(cgImage);
    return texture;
}

@end
