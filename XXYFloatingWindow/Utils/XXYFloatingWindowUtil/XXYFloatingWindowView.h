//
//  XXYFloatingWindowView.h
//  XXYFloatingWindow
//
//  Created by Jason_Xu on 2017/5/17.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXYFloatingWindowConfig.h"
#import "UIView+XXYViewFrame.h"
/**
  屏幕窗口状态

 - XXYFloatingWindowViewState_Default: 默认
 - XXYFloatingWindowViewState_FloatingWindow: 小窗口
 */
typedef NS_ENUM(NSInteger, XXYFloatingWindowViewState) {
    XXYFloatingWindowViewState_Default = 0,
    XXYFloatingWindowViewState_FloatingWindow = 1
};


@protocol XXYFloatingWindowViewDelegate <NSObject>


/**
 接受电话通话
 */
- (void)xxy_acceptCallButtonHandleWithIsCalled:(BOOL)isCalled;

/**
 结束通话操作
 */
- (void)xxy_endCallButtonHandle;

@end


@interface XXYFloatingWindowView : UIView
#pragma mark - attributes
/**
 声明代理
 */
@property (nonatomic, weak) id<XXYFloatingWindowViewDelegate>delegate;
/**
 状态
 */
@property (nonatomic, assign) XXYFloatingWindowViewState state;
//操作superview
@property (nonatomic, strong) UIView *superConcentView;
//小窗口button
@property (nonatomic, strong) UIButton *smallScreenButton;
//同意按钮
@property (nonatomic, strong) UIButton *acceptButton;
//结束按钮
@property (nonatomic, strong) UIButton *closeButton;
//当前总时间
@property (nonatomic, strong) UILabel *timeLabel;
// 播放器单击手势
@property (nonatomic, strong) UITapGestureRecognizer *callViewTap;
// 播放器拖动手势
@property (nonatomic, strong) UIPanGestureRecognizer *callPanGesture;
// 控制视图显示
@property (nonatomic, assign) BOOL isControlsHidden;
//头像
@property (nonatomic, strong) UIImageView *headerImageView;
// 控制视图隐藏定时器
@property (nonatomic, strong) NSTimer *controlsTimer;

@property (nonatomic, assign) BOOL isCalled;

#pragma mark - interface methods
/**
 init
 
 @param isVideo 判断是否是视频通话 调整视图
 @return <#return value description#>
 */
- (instancetype)initWithIsVideo:(BOOL)isVideo isCalled:(BOOL)isCalled;

@end
