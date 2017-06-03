//
//  XXYFloatingWindowView.m
//  XXYFloatingWindow
//
//  Created by Jason_Xu on 2017/5/17.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import "XXYFloatingWindowView.h"
#import <Masonry/Masonry.h>

@interface XXYFloatingWindowView ()

@property (nonatomic, strong) UIImageView *imageV;
/**
 是否滑动
 */
@property (nonatomic, assign) BOOL isSwiping;

/**
 是否视频
 */
@property (nonatomic, assign) BOOL isVideo;

@end

@implementation XXYFloatingWindowView

- (instancetype)initWithIsVideo:(BOOL)isVideo isCalled:(BOOL)isCalled{
    self = [super init];
    if (self) {
        self.isVideo = isVideo;
        self.isCalled = isCalled;
        [self xxy_setupSubviewsFloatingWindow];
    }
    return self;
}

- (void)xxy_setupSubviewsFloatingWindow{
    self.backgroundColor = kRGBA(193, 210, 240, .8);
    //添加视图
    [self xxy_setupSubviews];
    //设置手势
    [self xxy_setBaseConfig];
}

- (void)xxy_setupSubviews{
     [UIApplication sharedApplication].statusBarHidden = NO;
    //切换button
    self.smallScreenButton = [self xxy_floatingWindowViewButton];
    UIImage *image = kGetImage(@"btn_-cut_hujiao_normal");
    [self.smallScreenButton setBackgroundImage:image forState:UIControlStateNormal];
    self.smallScreenButton.tag = 10000;
    [self addSubview:self.smallScreenButton];
    
    //操作视图
    self.superConcentView = [[UIView alloc] init];
    self.superConcentView.alpha = 0;
    self.superConcentView.backgroundColor = kXXYGeneralColor_ClearColor;
    [self addSubview:self.superConcentView];
    //接受button
    self.acceptButton = [self xxy_floatingWindowViewButton];
    self.acceptButton.tag = 10001;
    UIImage *acceptBT = kGetImage(@"btn_jieting_huru_normal");
    [self.acceptButton setBackgroundImage:acceptBT forState:UIControlStateNormal];
    [self.superConcentView addSubview:self.acceptButton];
    //拒绝button
    UIImage *refuseBT = kGetImage(@"btn_guaduan_normal");
    self.closeButton = [self xxy_floatingWindowViewButton];
    self.closeButton.tag = 10002;
    [self.closeButton setBackgroundImage:refuseBT forState:UIControlStateNormal];
    [self.superConcentView addSubview:self.closeButton];
    //
    weakify(self)
    [weak_self.smallScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.mas_top).offset(20);
        make.right.equalTo(weak_self.mas_right);
        make.size.mas_equalTo(CGSizeMake(30 * kViewSizeScale, 30 * kViewSizeScale));
    }];
    //
    [UIView animateWithDuration:.5 animations:^{
        [weak_self.superConcentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(weak_self);
            make.height.mas_equalTo(kXXYScreenH/3 * kViewHeightScale);
        }];
        //
        [weak_self.acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weak_self.superConcentView.mas_top).offset(10);
            make.left.mas_equalTo(weak_self.superConcentView.left).offset(50);
            make.size.mas_equalTo(CGSizeMake(50 * kViewWidthScale, 30 * kViewHeightScale));
        }];
        //
        [weak_self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weak_self.superConcentView.mas_right).offset(-50);
            make.top.equalTo(weak_self.acceptButton);
            make.size.equalTo(weak_self.acceptButton);
        }];
    } completion:^(BOOL finished) {
        weak_self.superConcentView.alpha = 1;
    }];
}

//添加基本手势
- (void)xxy_setBaseConfig{
    //视图点击手势
    self.callViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xxy_callViewTapHandle:)];
    [self addGestureRecognizer:self.callViewTap];
    //视图右拖动手势
    self.callPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(xxy_swipePanGestureHandle:)];
    [self addGestureRecognizer:self.callPanGesture];
    //
    self.isControlsHidden = NO;
}

#pragma mark -- Events
//切换视图  全屏或小窗口
- (void)xxy_callViewTapHandle:(UITapGestureRecognizer *)callViewTap{
    if (XXYFloatingWindowViewState_FloatingWindow == self.state) {
        [UIView animateWithDuration:.3f animations:^{
            self.layer.cornerRadius = 0;
            self.layer.masksToBounds = NO;
            [self.imageV removeFromSuperview];
            self.imageV = nil;
            self.frame = kXXYScreenBounds;
        } completion:^(BOOL finished) {
            //点击屏幕 全屏状态 设置小窗口操作按钮
            [self xxy_setupSubviews];
        }];
    }else{
        //self.isControlsHidden ? [self startControlsTimer] : [self stopControlsTimer];
        self.isControlsHidden = !self.isControlsHidden;
    }
}
//拖动视图
- (void)xxy_swipePanGestureHandle:(UIPanGestureRecognizer *)panGesture{
    CGPoint translation = [panGesture translationInView:self];
    if (UIGestureRecognizerStateBegan == panGesture.state) {
        if (XXYFloatingWindowViewState_FloatingWindow == self.state && self.isSwiping) {
            [self xxy_startPanCallView];
        }
    }else if (UIGestureRecognizerStateCancelled == panGesture.state || UIGestureRecognizerStateEnded == panGesture.state){
        //
        if (XXYFloatingWindowViewState_FloatingWindow == self.state) {
            [self xxy_endPanPlayerViewWhenWindow];
        }
    }else if (UIGestureRecognizerStateChanged == panGesture.state){
        //
        if (XXYFloatingWindowViewState_FloatingWindow == self.state) {
            [self xxy_panPlayerViewWhenWindowWithPanGestureTranslation:translation];
        }
    }
}

#pragma mark -- PanPlayerViewHandle
- (void)xxy_startPanCallView{
    if (self.isSwiping) {
        return;
    }
    
    self.isSwiping = YES;
}

- (void)xxy_panPlayerViewWhenPortraitWithPanGestureDistance:(CGFloat)distance{
    if (distance <= 0) return;
    if (!self.isSwiping) return;
    
    CGFloat rate = distance / (kXXYScreenBounds.size.width*2);
    
    CGFloat widthPaddign = 15.f;
    CGFloat heightPadding = 45.f;
    
    if (!self.isVideo) {//语音
        [self setFrameOriginX:(kXXYScreenBounds.size.width - widthPaddign - KWindowDisplayWidth) * rate];
        [self setFrameOriginY:(kXXYScreenBounds.size.height - heightPadding - KWindowDisplayHeight) * rate];
    }else{//视频
        [self setFrameOriginX:(kXXYScreenBounds.size.width - widthPaddign - KWindowDisplayWidth1) * rate];
        [self setFrameOriginY:(kXXYScreenBounds.size.height - heightPadding - KWindowDisplayHeight1) * rate];
    }
    //
    [self setFrameWidth:kXXYScreenBounds.size.width - self.frame.origin.x - (widthPaddign * rate)];
    [self setFrameHeight:kXXYScreenBounds.size.height - self.frame.origin.y - (heightPadding * rate)];
}

- (void)xxy_panPlayerViewWhenWindowWithPanGestureTranslation:(CGPoint)translation{
    self.center = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
    [self.callPanGesture setTranslation:CGPointZero inView:[UIApplication sharedApplication].delegate.window];
}

- (void)xxy_endPanPlayerViewWhenPortrait{
    if (!self.isSwiping) {
        return;
    }
    //
    if (self.frame.origin.x >= 50.f) {
        self.state = XXYFloatingWindowViewState_FloatingWindow;
        [UIView animateWithDuration:.3 animations:^{
            
            self.frame = CGRectMake(kXXYScreenW - 15.f - KWindowDisplayWidth, kXXYScreenH - KWindowDisplayHeight - 45.f, KWindowDisplayWidth, KWindowDisplayHeight);
        } completion:^(BOOL finished) {
            self.isSwiping = NO;
        }];
    }else{
        [UIView animateWithDuration:.3f animations:^{
            self.frame = kXXYScreenBounds;
        } completion:^(BOOL finished) {
            self.isSwiping = NO;
            [UIApplication sharedApplication].statusBarHidden = YES;
        }];
    }
}

- (void)xxy_endPanPlayerViewWhenWindow{
    if (self.center.x <= kXXYScreenBounds.size.width / 2.f) {
        [UIView animateWithDuration:0.3f animations:^{
            CGPoint center = self.center;
            if (!self.isVideo) {
                center.x = 15.f + KWindowDisplayWidth / 2.f;
            }else{
                center.x = 15.f + KWindowDisplayWidth1 / 2.f;
            }
            //
            if (self.center.y < 15.f + KWindowDisplayHeight / 2.f) {
                center.y = 15.f + KWindowDisplayHeight / 2.f;
            } else if (self.center.y > kXXYScreenH - 15.f - KWindowDisplayHeight / 2.f) {
                center.y = kXXYScreenH - 15.f - KWindowDisplayHeight / 2.f;
            }
            self.center = center;
        }];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            CGPoint center = self.center;
            if (!self.isVideo) {//语音
                center.x = kXXYScreenW - 15.f - KWindowDisplayWidth / 2.f;
            }else{//视频
                center.x = kXXYScreenW - 15.f - KWindowDisplayWidth1 / 2.f;
            }
            //
            if (self.center.y < 15.f + KWindowDisplayHeight / 2.f) {
                center.y = 15.f + KWindowDisplayHeight / 2.f;
            } else if (self.center.y > kXXYScreenH - 15.f - KWindowDisplayHeight / 2.f) {
                center.y = kXXYScreenH - 15.f - KWindowDisplayHeight / 2.f;
            }
            self.center = center;
        }];
    }
}


- (UIButton *)xxy_floatingWindowViewButton{
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = kXXYGeneralColor_ClearColor;
        [button addTarget:self action:@selector(xxy_floatingWindowButtonWithSender:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)xxy_floatingWindowButtonWithSender:(UIButton *)sender{
    UIButton * button = sender;
    if (10000 == button.tag) {
        weakify(self)
        [UIView animateWithDuration:0.3 animations:^{
            __strong typeof(weak_self) strongSelf = weak_self;
            //
            [strongSelf xxy_removeSmallButton];
            [strongSelf xxy_removeSuperContentView];
            if (!strongSelf.isVideo) {//语音
                strongSelf.frame = CGRectMake(kXXYScreenW - 15.f - KWindowDisplayWidth, kXXYScreenH - KWindowDisplayHeight - 45.f, KWindowDisplayWidth, KWindowDisplayHeight);
                strongSelf.layer.cornerRadius = KWindowDisplayWidth / 2;
                strongSelf.layer.masksToBounds = YES;
                UIImage *image1 = kGetImage(@"btn_jieting_huru_normal");
                strongSelf.imageV = [[UIImageView alloc] initWithImage:image1];
                strongSelf.imageV.userInteractionEnabled = YES;
                [strongSelf addSubview:strongSelf.imageV];
                [strongSelf.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(strongSelf);
                }];
            }else{//视频
                self.frame = CGRectMake(kXXYScreenW - 15.f - KWindowDisplayWidth1, kXXYScreenH - KWindowDisplayHeight1 - 45.f, KWindowDisplayWidth1, KWindowDisplayHeight1);
            }
        }completion:^(BOOL finished) {
            self.isSwiping = YES;
            self.state = XXYFloatingWindowViewState_FloatingWindow;
        }];
    }
    if (10001 == button.tag) {//接听
        //需要添加 时间lable 显示通话时长  结束通话按钮
        if (self.delegate && [self.delegate respondsToSelector:@selector(xxy_acceptCallButtonHandleWithIsCalled:)]) {
            [self.delegate xxy_acceptCallButtonHandleWithIsCalled:self.isCalled];
        }
        
    }
    if (10002 == button.tag) {//拒绝
        if (self.delegate && [self.delegate respondsToSelector:@selector(xxy_endCallButtonHandle)]) {
            [self.delegate xxy_endCallButtonHandle];
        }
    }
}

//移除小窗口button
- (void)xxy_removeSmallButton{
    [self.smallScreenButton removeFromSuperview];
    self.smallScreenButton = nil;
    //
    [self.closeButton removeFromSuperview];
    self.closeButton = nil;
}

- (void)xxy_removeSuperContentView{
    [self.superConcentView removeFromSuperview];
    self.superConcentView = nil;
}


- (void)startControlsTimer
{
    [self stopControlsTimer];
    self.controlsTimer = [NSTimer scheduledTimerWithTimeInterval:KControlsHideInterval target:self selector:@selector(controlsTimerHandle) userInfo:nil repeats:NO];
}

- (void)stopControlsTimer
{
    if (self.controlsTimer.isValid) {
        [self.controlsTimer invalidate];
        self.controlsTimer = nil;
    }
}

- (void)controlsTimerHandle
{
    if (!self.isControlsHidden) {
        self.superConcentView.hidden = YES;
        self.isControlsHidden = YES;
    }
}

#pragma mark -- updateView
- (void)updateTimeLabel
{
   
}


@end
