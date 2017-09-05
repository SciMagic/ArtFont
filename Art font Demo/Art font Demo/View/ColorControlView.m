//
//  ColorControlView.m
//  Art font Demo
//
//  Created by QD-ZC on 2017/9/5.
//  Copyright © 2017年 Hacky. All rights reserved.
//

#import "ColorControlView.h"
#import "CBJPaletteView.h"

@interface ColorControlView () <CBJPaletteViewDelegate>

@property (nonatomic, copy) NSString *selectKey;

@end

@implementation ColorControlView

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
    [self addColorPicker];
    [self addClearBtn];
}


- (void)addSegmentControl:(NSArray<NSString *>*)segmentNames
{
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:segmentNames];
    control.center = CGPointMake(self.center.x, CGRectGetHeight(self.frame) - CGRectGetHeight(control.frame));
    [control addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    control.selectedSegmentIndex = 0;
    self.selectKey = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
    [self addSubview:control];
}

- (void)addColorPicker
{
    CBJPaletteView *palette = [[CBJPaletteView alloc] initWithPaletteType:PaletteHexagon withFrame:CGRectMake(0, 0, 150, 150)];
    palette.center = CGPointMake(self.center.x + 75, CGRectGetHeight(self.frame) - CGRectGetHeight(palette.frame));
    palette.delegate = self;
    [self addSubview:palette];
}

- (void)addClearBtn
{
    UIButton *botton = [UIButton buttonWithType:UIButtonTypeSystem];
    [botton setTitle:@"set conter clear" forState:UIControlStateNormal];
    botton.frame = CGRectMake(0, 0, 110, 100);
    botton.center = CGPointMake(self.center.x - 100, CGRectGetHeight(self.frame) - 150.f);
    [botton addTarget:self action:@selector(clearBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:botton];
}

- (void)segmentChanged:(UISegmentedControl *)control
{
    self.selectKey = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
}

- (void)clearBtnClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectColor:forKey:)]) {
        
        [self.delegate didSelectColor:[UIColor clearColor] forKey:self.selectKey];
        
    }
}

#pragma mark ---CBJPaletteViewDelegate---
- (void)didSelectColor:(CBJPaletteView *)view selectedColor:(UIColor *)color
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectColor:forKey:)]) {
     
        [self.delegate didSelectColor:color forKey:self.selectKey];
        
    }
}

@end
