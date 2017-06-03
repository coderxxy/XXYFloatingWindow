//
//  XXYFloatingWindow.h
//  XXYFloatingWindow
//
//  Created by Jason_Xu on 2017/5/17.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXYFloatingWindowView.h"

typedef NS_ENUM(NSInteger, XXYCallState){
    XXYCallStateUnknown,
    XXYCallStateContentLoading,
    XXYCallStateContentPlaying,
    XXYCallContentPaused,
    XXYCallStateSuspend,
    XXYCallStateDismissed,
    XXYCallStateError
};

@protocol XXYFloatingWindowDelegate <NSObject>

/**
 结束通话
 */
- (void)xxy_endCallButtonOperation;

@end

@interface XXYFloatingWindow : NSObject

//通话视图管理view
@property (nonatomic, strong) XXYFloatingWindowView *callManagerView;
//初始化代理
@property (nonatomic, weak) id <XXYFloatingWindowDelegate> delegate;
//当前操作状态
@property (nonatomic, assign) XXYCallState state;
//竖屏frame
@property (nonatomic, assign) CGRect portraitFrame;
//
@property (nonatomic, assign) CGRect landscapeFrame;

/**
 通话成员数组
 */
@property (nonatomic, strong) NSArray *phonesArray;

/**
 是否全屏
 */
@property (nonatomic, assign) BOOL isFullScreen;

/**
 是否视频通话
 */
@property (nonatomic, assign) BOOL isVideo;

/**
 是否是被叫
 */
@property (nonatomic, assign) BOOL isCalled;

/**
 是否正在通话、视频中...
 */
@property (nonatomic, assign) BOOL isCalling;

/**
 初始化
 
 @param phones 成员电话
 @param isVideo 是否是视频
 @param isCalled 是否是被叫
 @return <#return value description#>
 */
- (instancetype)initWithNumbers:(NSArray *)phones
                        isVideo:(BOOL)isVideo
                       isCalled:(BOOL)isCalled;
/**
 开始通话
 */
- (void)xxy_startCallManagerWithNumbers;


@end
