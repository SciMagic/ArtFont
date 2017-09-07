//
//  ColorControlView.h
//  Art font Demo
//
//  Created by QD-ZC on 2017/9/5.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorControlViewDelegate <NSObject>

- (void)didSelectColor:(UIColor *)color forKey:(NSString *)key;

- (NSString *)getStyleString;

@end

@interface ColorControlView : UIView

- (void)addSegmentControl:(NSArray<NSString *>*)segmentNames;

- (void)updateInfo;
@property (weak, nonatomic) id<ColorControlViewDelegate> delegate;

@end
