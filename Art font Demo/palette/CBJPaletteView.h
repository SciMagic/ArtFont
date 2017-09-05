//
//  CBJPaletteView.h
//  Palette
//
//  Created by 超八机 on 2017/7/30.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBJPaletteView;

@protocol CBJPaletteViewDelegate <NSObject>

@optional
- (void)didSelectColor:(CBJPaletteView *)view selectedColor:(UIColor *)color;

@end

typedef enum : NSUInteger {
    PaletteStrip,
    PaletteCircle,
    PaletteHexagon,
} PaletteType;


//use set frame to change the position
@interface CBJPaletteView : UIView

- (instancetype)initWithPaletteType:(PaletteType)type withFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithPaletteImage:(UIImage *)image withFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@property(weak, nonatomic) id<CBJPaletteViewDelegate> delegate;

@end
