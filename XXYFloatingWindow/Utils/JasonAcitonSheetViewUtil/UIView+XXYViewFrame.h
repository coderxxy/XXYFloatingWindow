//
//  UIView+XXYViewFrame.h
//  截取字符串
//
//  Created by Jason_Xu on 2017/4/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XXYViewFrame)
/**
 *  1.间隔X值
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  2.间隔Y值
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  3.宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  4.高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  5.中心点X值
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  6.中心点Y值
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  7.尺寸大小
 */
@property (nonatomic, assign) CGSize size;

/**
 *  8.起始点
 */
@property (nonatomic, assign) CGPoint origin;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 宽度
 
 @param newWidth <#newWidth description#>
 */
- (void)setFrameWidth:(CGFloat)newWidth;

/**
 高度
 
 @param newHeight <#newHeight description#>
 */
- (void)setFrameHeight:(CGFloat)newHeight;

/**
 起始点 x
 
 @param newX <#newX description#>
 */
- (void)setFrameOriginX:(CGFloat)newX;

/**
 起始点y
 
 @param newY <#newY description#>
 */
- (void)setFrameOriginY:(CGFloat)newY;


/**
 *  1.添加边框
 *
 *  @param color <#color description#>
 */
- (void)rcs_addBorderColor:(UIColor *)color;

/**
 *  2.UIView 的点击事件
 *
 *  @param target   目标
 *  @param action   事件
 */

- (void)rcs_addTarget:(id)target
               action:(SEL)action;

@end
