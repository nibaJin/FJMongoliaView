//
//  FJMongoliaView.m
//  jiuhuar
//
//  Created by fujin on 16/5/18.
//  Copyright © 2016年 Jiuhuar. All rights reserved.
//

#import "FJMongoliaView.h"

#define HexAlphaColor(rgbValue, alp) [UIColor colorWithRed:((float) ((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float) ((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float) (rgbValue & 0xFF)) / 255.0 alpha:alp]
#define MongoliaColor HexAlphaColor(0x000000, 0.7)
#define USER_DEFAULT [NSUserDefaults standardUserDefaults] 

@interface FJMongoliaView ()

@property (nonatomic, strong) UIImageView *bbsImageView;
@end

@implementation FJMongoliaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       //
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius hintImage:(UIImage *)hintImgae imageFrame:(CGRect)imageFrame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self configRoundedRect:rect cornerRadius:radius];
        [self addImage:hintImgae inRect:imageFrame];
        [self addHiddenGesTap];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withCircleCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle hintImage:(UIImage *)hintImgae imageFrame:(CGRect)imageFrame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self configCircleCenter:center radius:radius startAngle:startAngle endAngle:endAngle];
        [self addImage:hintImgae inRect:imageFrame];
        [self addHiddenGesTap];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withRoundedRects:(NSArray <NSValue *> *)rects hintImage:(UIImage *)hintImgae imageFrame:(CGRect)imageFrame;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self configRoundedRects:rects];
        [self addImage:hintImgae inRect:imageFrame];
        [self addHiddenGesTap];
    }
    return self;
}

#pragma mark - addGesTap
- (void)addHiddenGesTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

#pragma mark - config monglia layer
- (void)configRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    
    [path appendPath:cornerPath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = MongoliaColor.CGColor;
    
    [self.layer addSublayer:fillLayer];
}

- (void)configCircleCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];

    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath moveToPoint:center];
    [circlePath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [circlePath closePath];
    
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = MongoliaColor.CGColor;
    
    [self.layer addSublayer:fillLayer];
}

- (void)configRoundedRects:(NSArray *)rects
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    
    for (NSValue *rectValue in rects) {
        CGRect rect = [rectValue CGRectValue];
        UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
        
        [path appendPath:cornerPath];
        [path setUsesEvenOddFillRule:YES];
    }

    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = MongoliaColor.CGColor;
    
    [self.layer addSublayer:fillLayer];
}

- (void)addImage:(UIImage *)hintImage inRect:(CGRect)rect
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = hintImage;
    [self addSubview:imageView];
}

#pragma mark --- user control
- (void)showInView:(UIView *)view
{
    self.alpha = 0;
    [view addSubview:self];
    __weak FJMongoliaView *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tapAction
{
    __weak FJMongoliaView *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        if (weakSelf.tapCallBlock) {
            weakSelf.tapCallBlock();
        }
        if (weakSelf.key) {
            [USER_DEFAULT setObject:@(NO) forKey:weakSelf.key];
            [USER_DEFAULT synchronize];
        }
        [weakSelf removeFromSuperview];
    }];
}

@end
