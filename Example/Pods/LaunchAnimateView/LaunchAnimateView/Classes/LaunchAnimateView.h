//
//  LaunchAnimateView.h
//  Demo
//
//  Created by LYPC on 2018/3/23.
//  Copyright © 2018年 LYPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchAnimateView : UIView

@property (nonatomic,strong) UIButton *timeBtn;

/**
 设置本地图片

 @param imgName 图片名字
 @param frame 位置（以整个屏幕为父视图）
 */
- (void)configAnimateImg:(NSString *)imgName position:(CGRect)frame;

/**
 设置网络图片
 
 @param imgUrl 图片链接
 @param frame 位置（以整个屏幕为父视图）
 */
- (void)configAnimateImgUrl:(NSString *)imgUrl position:(CGRect)frame;

/**
 设置视频
 
 @param videoUrl 视频链接
 @param frame 位置（以整个屏幕为父视图）
 */
- (void)configAnimateVideoUrl:(NSString *)videoUrl position:(CGRect)frame;

/** 倒计时时长  */
@property (nonatomic,assign) int playDurition;
/** 播放完成是否重复播放  */
@property (nonatomic,assign) BOOL isRepeatPlay;

/**
 设置跳过（倒计时按钮的位置）

 @param frame 位置（以整个屏幕为父视图）
 */
- (void)setupTimeBtnPosition:(CGRect)frame;

@end
