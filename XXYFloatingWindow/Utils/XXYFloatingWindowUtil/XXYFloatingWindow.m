//
//  XXYFloatingWindow.m
//  XXYFloatingWindow
//
//  Created by Jason_Xu on 2017/5/17.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import "XXYFloatingWindow.h"


@interface XXYFloatingWindow ()<XXYFloatingWindowViewDelegate>

@end

@implementation XXYFloatingWindow
- (instancetype)initWithNumbers:(NSArray *)phones isVideo:(BOOL)isVideo isCalled:(BOOL)isCalled{
    self = [super init];
    if (self) {
        self.phonesArray = phones;
        self.isVideo = isVideo;
        self.isCalled = isCalled;
        
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.callManagerView = [[XXYFloatingWindowView alloc] initWithIsVideo:self.isVideo isCalled:self.isCalled];
    self.callManagerView.delegate = self;
    self.portraitFrame = CGRectMake(0, 0, MIN(kXXYScreenBounds.size.width, kXXYScreenBounds.size.height), MAX(kXXYScreenBounds.size.width, kXXYScreenBounds.size.height));
    self.landscapeFrame = kXXYScreenBounds;
}

#pragma mark - 通话 视屏 ...操作
- (void)xxy_startCallManagerWithNumbers{
    
}
#pragma mark - XXYFloatingWindowViewDelegate
//挂断或者拒接
- (void)xxy_endCallButtonHandle{
    if (self.delegate && [self.delegate respondsToSelector:@selector(xxy_endCallButtonOperation)]) {
        [self.delegate xxy_endCallButtonOperation];
    }
}
//接听 或者发起
- (void)xxy_acceptCallButtonHandleWithIsCalled:(BOOL)isCalled{
    NSString *str = nil;
    if (isCalled) {
       str = @"接电话";
    }else{
        str = @"拨电话";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hit" message:str delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark -- DeivceOrientation
- (void)performOrientationChange:(UIInterfaceOrientation)deviceOrientation {
    //
    __weak __typeof__(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        CGRect viewBoutnds;
        if (UIInterfaceOrientationIsLandscape(deviceOrientation)) {
            viewBoutnds = CGRectMake(0, 0, CGRectGetWidth(self.landscapeFrame), CGRectGetHeight(self.landscapeFrame));
        } else {
            viewBoutnds = CGRectMake(0, 0, CGRectGetWidth(self.portraitFrame), CGRectGetHeight(self.portraitFrame));
        }
        
        weakSelf.callManagerView.bounds = viewBoutnds;
        [weakSelf.callManagerView setFrameOriginX:0.0f];
        [weakSelf.callManagerView setFrameOriginY:0.0f];
        
        CGRect wvFrame = weakSelf.callManagerView.superview.frame;
        if (wvFrame.origin.y > 0) {
            wvFrame.size.height = CGRectGetHeight(kXXYScreenBounds) ;
            wvFrame.origin.y = 0;
            weakSelf.callManagerView.frame = wvFrame;
        }
    } completion:^(BOOL finished) {
        
    }];
}





@end
