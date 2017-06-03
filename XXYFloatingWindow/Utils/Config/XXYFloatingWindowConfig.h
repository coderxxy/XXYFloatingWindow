//
//  XXYFloatingWindowConfig.h
//  XXYFloatingWindow
//
//  Created by Jason_Xu on 2017/5/17.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#ifndef XXYFloatingWindowConfig_h
#define XXYFloatingWindowConfig_h

typedef void (^VoidBlock)();

#define kXXYScreenW [UIScreen mainScreen].bounds.size.width
#define kXXYScreenH [UIScreen mainScreen].bounds.size.height
#define kXXYScreenBounds [UIScreen mainScreen].bounds

#define kXXYNavgationBarHeight   64.0f
#define KControlsHideInterval 5.f
//语音
#define KWindowDisplayWidth 50.f
#define KWindowDisplayHeight 50.f 
/// (16.f / 9.f)
//视频
#define KWindowDisplayWidth1 kXXYScreenBounds.size.width/3
#define KWindowDisplayHeight1 kXXYScreenBounds.size.height/3

#define degreesToRadians(x) (M_PI * x / 180.0f)
//十六进制色值
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//
#define kIOS8UP ([[UIDevice currentDevice].systemVersion floatValue] >= 8)
// 设置view的圆角边框
#define LRViewBorderRadius(View, Radius, Width, Color)\\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// 判断当前的iPhone设备/系统版本
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// 沙盒目录文件
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//通知
#define kXXYNotificationCenter [NSNotificationCenter defaultCenter]

#ifdef DEBUG
#define kXXYLog(...) NSLog(__VA_ARGS__)
#else
#define kXXYLog(...)
#endif
//打印当前方法
#define kXXYLogFunc XXYLog(@"%s", __func__)

//判断系统版本
#define IOS_VERSION_7_OR_Below (([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0)? (YES):(NO))
#define IOS_VERSION_7_OR_Above (([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0)? (YES):(NO))

#define IOS_VERSION_8_OR_Above (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))

#define IOS_VERSION_9_OR_Above (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)? (YES):(NO))

//视图适配
#define kIphone6ScreenHeight    667.0f
#define kIphone6ScreenWidth     375.0f
//适配 屏幕比例
#define kViewWidthScale (kXXYScreenW / kIphone6ScreenWidth)
#define kViewHeightScale (kXXYScreenH / kIphone6ScreenHeight)
#define kViewSizeScale    kViewHeightScale/kViewWidthScale
//获取image
#define kGetImage(imageName)     [UIImage imageNamed:imageName]
//超时时间处理
#define kTimeoutInterval 30.0f
//语音沙河路径
#define kDocumentPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//判断当前设备机型是否为6
#define kIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判读字符串
#define kISValidNSString(x) (x != NULL && [x length] > 0)

#pragma mark - weakify & strongify
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) __block __typeof__(object) block##_##object = object;
#endif
#endif
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) __typeof__(object) strong##_##object = block##_##object;
#endif
#endif
//颜色
#define kXXYColor_BlackColor                 [UIColor blackColor]
#define kXXYGeneralColor_WhiteColor          [UIColor whiteColor]
#define kXXYGeneralColor_ClearColor          [UIColor clearColor]
//颜色
#define kXXYGlobalBg XXYColor(223, 223, 223)
//#define kXXYGlobalSpaceColor
// 设置颜色RGB值
#define kRGBColor(a,b,c) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:1.0]
// 设置颜色RGB值+透明度
#define kRGBA(a,b,c,d) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:d]
// 设置随机颜色
#define kLRRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]



#endif /* XXYFloatingWindowConfig_h */
