# XXYFloatingWindow
防qq、微信通话、视频悬浮窗。

![image](https://github.com/JasonDraem/XXYFloatingWindow/blob/master/XXYFloatingWindow/ImageSource/Untitled.gif)

![image](https://github.com/JasonDraem/XXYFloatingWindow/blob/master/XXYFloatingWindow/ImageSource/屏幕快照%202017-06-02%20下午3.36.12.png)

使用接口:

 开始通话
 
 @param phones 成员电话 (可以为number， 具体根据需求可以更改接口和传参值)
 @param isVideo 是否是视频通话
 @param isCalled 是否是被叫
 */
- (void)xxy_startCallWithNumbers:(NSArray *)phones
                         isVideo:(BOOL)isVideo
                        isCalled:(BOOL)isCalled;
  //语音                      
 [[XXYFloatingWindowUtil xxy_shareInstance] xxy_startCallWithNumbers:nil isVideo:NO isCalled:NO];
 //视频
 [[XXYFloatingWindowUtil xxy_shareInstance] xxy_startCallWithNumbers:nil isVideo:YES isCalled:NO];
                     
