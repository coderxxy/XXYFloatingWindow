//
//  XXYActionSheetView.h
//  截取字符串
//
//  Created by Jason_Xu on 2017/4/27.
//  Copyright © 2017年 Jason_Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXYActionSheetView;


@protocol XXYActionSheetViewDelegate <NSObject>

@optional

/**
 选中第几个

 @param actionSheet <#actionSheet description#>
 @param buttonIndex <#buttonIndex description#>
 */
- (void)actionSheet:(XXYActionSheetView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

/**
 即将消失

 @param actionSheet <#actionSheet description#>
 @param buttonIndex <#buttonIndex description#>
 */
- (void)actionSheet:(XXYActionSheetView *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;

/**
 已经消失

 @param actionSheet <#actionSheet description#>
 @param buttonIndex <#buttonIndex description#>
 */
- (void)actionSheet:(XXYActionSheetView *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;


@end

typedef void(^XXYActionSheetViewBlock)(NSInteger index);

@interface XXYActionSheetView : UIView

/**
 操作按钮个数
 */
@property (nonatomic, assign, readonly) NSInteger numberOfButtons;

/**
 取消按钮
 */
@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;

/**
 <#Description#>
 */
@property (nonatomic, assign, readonly) NSInteger destructiveButtonIndex;

/**
 声明代理
 */
@property (nonatomic, weak) id<XXYActionSheetViewDelegate>actionSheetViewDelegate;

/**
 操作block
 */
@property (nonatomic, copy) XXYActionSheetViewBlock acitonSheetBlock;

/**
 <#Description#>

 @param id <#id description#>
 @return <#return value description#>
 */
#pragma mark - methods

/**
 初始化 代理方法调用

 @param title <#title description#>
 @param delegate <#delegate description#>
 @param cancelButtonTitle <#cancelButtonTitle description#>
 @param destructiveButtonTitle <#destructiveButtonTitle description#>
 @param otherButtonTitles <#otherButtonTitles description#>
 @return <#return value description#>
 */
- (instancetype)initWithTitle:(NSString *)title
           delegate:(id<XXYActionSheetViewDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

/**
 初始化   block方式调用

 @param title 提示语
 @param cancelButtonTitle 取消按钮
 @param destructiveButtonTitle 确定按钮
 @param otherButtons 其他操作 可以为nil
 @param actionSheetBlock 操作事件block
 @return <#return value description#>
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtons
             actionSheetBlock:(XXYActionSheetViewBlock)actionSheetBlock;

/**
 显示
 */
- (void)xxy_show;

/**
 点击操作按钮

 @param buttonIndex <#buttonIndex description#>
 @return <#return value description#>
 */
- (NSString *)xxy_buttonTitleAtIndex:(NSInteger)buttonIndex;

@end
