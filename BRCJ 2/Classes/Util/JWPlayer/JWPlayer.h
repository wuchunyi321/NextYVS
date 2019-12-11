//
//  JWPlayer.h
//  JWPlayer
//
//  Created by jarvis on 2016/11/12.
//  Copyright © 2016年 jarvis jiangjjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class JWPlayer;

@protocol JWPlayerDelegate <NSObject>

@optional
-(void)playerTransfer:(JWPlayer *)player withIsLandscape:(NSNumber *)landscape;
- (void)playFinished;
@end

@interface JWPlayer : UIView

/**
 切换横竖屏时候
 **/
@property (nonatomic,weak)id<JWPlayerDelegate> delegate;

/**
 *  AVPlayer播放器
 */
@property (nonatomic, strong) AVPlayer *player;
/**
 *  播放状态，YES为正在播放，NO为暂停
 */
@property (nonatomic, assign) BOOL isPlaying;
/**
 *  是否横屏，默认NO -> 竖屏
 */
@property (nonatomic, assign) BOOL isLandscape;

/**
 *  传入视频地址
 *
 *   string 视频url
 */
- (void)updatePlayerWith:(NSURL *)url;

/**
 *  移除通知&KVO
 */
- (void)removeObserverAndNotification;

/**
 *  横屏Layout
 */
- (void)setlandscapeLayout;

/**
 *  竖屏Layout
 */
- (void)setPortraitLayout;

/**
 *  播放
 */
- (void)play;

/**
 *  暂停
 */
- (void)pause;
/**
 *在父视图显示
 */
-(void)showInSuperView:(UIView*)SuperView andSuperVC:(UIViewController*)SuperVC;

- (IBAction)rotationChanged:(id)sender;

@end
