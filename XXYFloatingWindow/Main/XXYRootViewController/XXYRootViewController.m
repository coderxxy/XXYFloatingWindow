//
//  XXYRootViewController.m
//  XXYFloatingWindow
//
//  Created by Jason_Xu on 2017/5/17.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import "XXYRootViewController.h"
#import "XXYFloatingWindowConfig.h"

#import "XXYFloatingWindowUtil.h"
#import "XXYActionSheetView.h"

@interface XXYRootViewController ()

@end

@implementation XXYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kLRRandomColor;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    static XXYActionSheetView *alertSheetView = nil;
    alertSheetView = [[XXYActionSheetView alloc] initWithTitle:nil cancelButtonTitle:@"取 消" destructiveButtonTitle:nil otherButtonTitles:@[@"语音通话", @"视频通话"] actionSheetBlock:^(NSInteger index) {
        
        if (0 == index) {//语音
            [[XXYFloatingWindowUtil xxy_shareInstance] xxy_startCallWithNumbers:nil isVideo:NO isCalled:NO];
        }
        if (1 == index) {//视频
            [[XXYFloatingWindowUtil xxy_shareInstance] xxy_startCallWithNumbers:nil isVideo:YES isCalled:NO];
        }
    }];

    [alertSheetView xxy_show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
