//
//  UIImage+XXYImageColor.m
//  截取字符串
//
//  Created by Jason_Xu on 2017/4/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import "UIImage+XXYImageColor.h"

@implementation UIImage (XXYImageColor)
//
+ (UIImage *)xxy_imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
