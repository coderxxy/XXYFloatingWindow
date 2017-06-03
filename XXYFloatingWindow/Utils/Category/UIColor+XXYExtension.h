//
//  UIColor+XXYExtension.h
//  MCRM
//
//  Created by Jason on 16/8/6.
//
//

#import <UIKit/UIKit.h>
//Hex :十六进制
@interface UIColor (XXYExtension)
//透明度固定为1，以0x开头的十六进制转换的颜色
+ (UIColor *)colorWithHex:(long)hexColor;
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor
                    alpha:(float)alpha;
// iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *)colorWithHexString:(NSString *)color;
// iOS中十六进制的颜色（以#开头）转换为UIColor 透明度可调整
+ (UIColor *)colorWithHexString:(NSString *)color
                          alpha:(float)alpha;

//#666666
+ (UIColor *)xxy_grayColor;
//#1d1d26
+ (UIColor *)xxy_blackColor;
//#e14238
+ (UIColor *)xxy_redColor;
//#ee7524
+ (UIColor *)xxy_orangeColor;
// clearcolor
+ (UIColor *)xxy_clearColor;
@end
