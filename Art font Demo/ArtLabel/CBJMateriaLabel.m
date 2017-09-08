//
//  CBJMateriaLabel.m
//  Art font Demo
//
//  Created by QD-ZC on 2017/9/8.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "CBJMateriaLabel.h"

@interface CBJMateriaLabel ()


@end

@implementation CBJMateriaLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawTextInRect:(CGRect)rect
{
    
    if (!self.materiaImage) {
        
        [super drawTextInRect:rect];
        return;
        
    }
    
    
    self.textColor = [UIColor whiteColor];
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    [super drawTextInRect:rect];
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    UIGraphicsEndImageContext();
    
    
    CIImage *inputImage = [CIImage imageWithCGImage:imageRef];
    CIFilter *filter = [CIFilter filterWithName:@"CIHeightFieldFromMask"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *outputImage = filter.outputImage;
    CGImageRelease(imageRef); imageRef = NULL;
    
    
    CIImage *materia = [CIImage imageWithCGImage:self.materiaImage.CGImage];
    
    CIFilter *filterMaterial = [CIFilter filterWithName:@"CIShadedMaterial"];
    [filterMaterial setValue:outputImage forKey:kCIInputImageKey];
    [filterMaterial setValue:materia forKey:kCIInputShadingImageKey];
    
    CIImage *finalEffect = filterMaterial.outputImage;
    
    UIImage *finalImage = [UIImage imageWithCIImage:finalEffect];
    
    [finalImage drawInRect:rect];

    
}

- (void)setMateriaImage:(UIImage *)materiaImage
{
    _materiaImage = materiaImage;
    [self setNeedsDisplay];
}

@end
