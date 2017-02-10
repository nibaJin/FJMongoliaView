//
//  FJMongoliaView.h
//  jiuhuar
//
//  Created by fujin on 16/5/18.
//  Copyright © 2016年 Jiuhuar. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapCallBackBlock) (void);

@interface FJMongoliaView : UIView

@property (nonatomic, copy) NSString *key;

@property (nonatomic, copy) TapCallBackBlock tapCallBlock;

/* round rect contain radius*/
- (instancetype)initWithFrame:(CGRect)frame withRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius hintImage:(UIImage *)hintImgae imageFrame:(CGRect)imageFrame;

/* circle or radius circle -- clockwise is Yes */
- (instancetype)initWithFrame:(CGRect)frame withCircleCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle hintImage:(UIImage *)hintImgae imageFrame:(CGRect)imageFrame;

/* one or more round rect */
- (instancetype)initWithFrame:(CGRect)frame withRoundedRects:(NSArray <NSValue *> *)rects hintImage:(UIImage *)hintImgae imageFrame:(CGRect)imageFrame;

- (void)showInView:(UIView *)view;

@end
