//
//  XXYFloatingWindowUtil.h
//  XXYFloatingWindow
//
//  Created by Jason_Xu on 2017/5/17.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>


@class XXYFloatingWindow;

@interface XXYFloatingWindowUtil : NSObject
/**
 通话管理
 */
@property (nonatomic, strong, readonly) XXYFloatingWindow *currentCallManager;

+ (instancetype)xxy_shareInstance;

/**
 开始通话
 
 @param phones 成员电话
 @param isVideo 是否是视频通话
 @param isCalled 是否是被叫
 */
- (void)xxy_startCallWithNumbers:(NSArray *)phones
                         isVideo:(BOOL)isVideo
                        isCalled:(BOOL)isCalled;

- (void)xxy_dismissCurrentFloatView;


@end
