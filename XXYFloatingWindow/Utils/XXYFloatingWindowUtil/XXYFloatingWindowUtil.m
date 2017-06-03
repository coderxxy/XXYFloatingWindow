//
//  XXYFloatingWindowUtil.m
//  XXYFloatingWindow
//
//  Created by Jason_Xu on 2017/5/17.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import "XXYFloatingWindowUtil.h"
#import "XXYFloatingWindow.h"

@interface XXYFloatingWindowUtil ()<XXYFloatingWindowDelegate>
// 通话管理对象
@property (nonatomic, strong) XXYFloatingWindow *currentCallManager;
// 保存通话对象（当正在通话时，点击操作通话操作）
@property (nonatomic, strong) XXYFloatingWindow *oldCurrentCallManager;
//正在通话、视频中
@property (nonatomic, assign) BOOL isCalling;
//原通话数据
@property (nonatomic, strong) NSArray *oldData;
//当前通话视图
@property (nonatomic, strong) UIView *currentView;

@end


@implementation XXYFloatingWindowUtil

+ (instancetype)xxy_shareInstance{
    static XXYFloatingWindowUtil *floatViewUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatViewUtil = [[XXYFloatingWindowUtil alloc] init];
    });
    return floatViewUtil;
}
//
- (void)xxy_startCallWithNumbers:(NSArray *)phones isVideo:(BOOL)isVideo isCalled:(BOOL)isCalled{
    
    [self.currentCallManager.callManagerView removeFromSuperview];
    // 1.初始化通话管理
    self.currentCallManager = [[XXYFloatingWindow alloc] initWithNumbers:phones isVideo:isVideo isCalled:isCalled];
    self.currentCallManager.callManagerView.frame = [UIScreen mainScreen].bounds;
    // 2.设置代理
    self.currentCallManager.delegate = self;
    self.currentCallManager.callManagerView.alpha = .0f;
    
    if (self.isCalling) {//通话或视频中
        //提示框
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"正在通话中..." delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        // 3.获取保存的通话对象
        self.oldCurrentCallManager.delegate = self;
        // 4.获取原通话成员数据
        self.currentCallManager.phonesArray = self.oldData;
        // 5.设置尺寸
        self.currentCallManager.callManagerView = (XXYFloatingWindowView *)self.currentView;
        //
        [[UIApplication sharedApplication].delegate.window addSubview:self.currentCallManager.callManagerView];
        self.currentView.alpha = 1.0f;
        
    }else{//未通话或视频
        
        [UIView animateWithDuration:.3f animations:^{
            [[UIApplication sharedApplication].delegate.window addSubview:self.currentCallManager.callManagerView];
            self.currentCallManager.callManagerView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            // 6.新的通话中 将状态设置为 正在通话中
            self.isCalling = YES;
            // 7.保存原通话数据: @[@"号码"]
            self.oldData = phones;
            // 8.保存当前号码通话view
            self.currentView = self.currentCallManager.callManagerView;
            // 9.保存当前通话管理对象
            self.oldCurrentCallManager = self.currentCallManager;
            // 10.开始通话或视频
            [self.currentCallManager xxy_startCallManagerWithNumbers];
        }];
    }
}
//悬浮窗口消失
- (void)xxy_dismissCurrentFloatView{
    [UIView animateWithDuration:.3f animations:^{
        self.currentCallManager.callManagerView.alpha = .0f;
        self.isCalling = NO;
    } completion:^(BOOL finished) {
        [self.currentCallManager.callManagerView removeFromSuperview];
        self.currentCallManager = nil;
    }];
}

#pragma mark - CallManagerDelegate
//结束通话操作
- (void)xxy_endCallButtonOperation{
    [self xxy_dismissCurrentFloatView];
}


@end
