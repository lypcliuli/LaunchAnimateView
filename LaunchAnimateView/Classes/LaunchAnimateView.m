//
//  LaunchAnimateView.m
//  Demo
//
//  Created by LYPC on 2018/3/23.
//  Copyright © 2018年 LYPC. All rights reserved.
//

#import "LaunchAnimateView.h"
#import <AVFoundation/AVFoundation.h>

#define SCREENW [[UIScreen mainScreen] bounds].size.width

@interface LaunchAnimateView()

@property (nonatomic ,strong) dispatch_source_t timer;
@property (nonatomic,strong) AVPlayerItem *playerItem;
@property (nonatomic,strong) AVPlayer *player;
@end

@implementation LaunchAnimateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.playDurition = 4;
        [self.timeBtn setFrame:CGRectMake(SCREENW-60-10, 55, 60, 40)];
    }
    return self;
}

- (void)configAnimateImg:(NSString *)imgName position:(CGRect)frame {
    CGRect imgFrame = [self convertRect:frame fromView:self];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgFrame];
    imageView.image = [UIImage imageNamed:imgName];
    [self addSubview:imageView];
    [self bringSubviewToFront:self.timeBtn];
}

- (void)configAnimateImgUrl:(NSString *)imgUrl position:(CGRect)frame {
    
    NSURL *photourl = [NSURL URLWithString:imgUrl];
    //url请求实在UI主线程中进行的
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取uiimage
    CGRect imgFrame = [self convertRect:frame fromView:self];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgFrame];
    imageView.image = image;
    [self addSubview:imageView];
    [self bringSubviewToFront:self.timeBtn];
}

- (void)configAnimateVideoUrl:(NSString *)videoUrl position:(CGRect)frame {
    // 加载网络视频
    NSURL *movieUrl = [NSURL URLWithString:videoUrl];
    // 1、得到视频的URL
    // 2、根据URL创建AVPlayerItem
    self.playerItem   = [AVPlayerItem playerItemWithURL:movieUrl];
    // 3、把AVPlayerItem 提供给 AVPlayer
    self.player     = [AVPlayer playerWithPlayerItem:self.playerItem];
    // 4、AVPlayerLayer 显示视频。
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame       = frame;
    //设置边界显示方式 填充
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer addSublayer:playerLayer];
    if (self.isRepeatPlay) {
        // 如果自动循环播放
        //给AVPlayerItem添加播放完成通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    }
    [self.player play];
    [self bringSubviewToFront:self.timeBtn];
}

/**
 *  播放完成通知
 *
 *  @param notification 通知对象
 */
- (void)playbackFinished:(NSNotification *)notification {
    NSLog(@"视频播放完成.");
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player play];
}

- (void)setupTimeBtnPosition:(CGRect)frame {
    CGRect btnFrame = [self convertRect:frame fromView:self];
    [self.timeBtn setFrame:btnFrame];
}

#pragma mark 点击跳过 或者 倒计时结束调用该方法消失
- (void)closeAnimateView {
    [UIView animateWithDuration:0.8 animations:^{
        self.alpha = 0.0;
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self removeFromSuperview];
    }];
}

- (UIButton *)timeBtn {
    if (!_timeBtn) {
        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeBtn setTitle:[NSString stringWithFormat:@"跳过%i", self.playDurition] forState:0];
        [_timeBtn setTitleColor:[UIColor grayColor] forState:0];
        [_timeBtn addTarget:self action:@selector(closeAnimateView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_timeBtn];
        dispatch_queue_t queue = dispatch_get_main_queue();
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(self.timer, ^{
            self.playDurition --;
            if (self.playDurition==0) {
                [_timeBtn setTitle:@"跳过" forState:UIControlStateNormal];
                dispatch_source_cancel(self.timer);
                [self closeAnimateView];
            }else {
                [_timeBtn setTitle:[NSString stringWithFormat:@"跳过%i", self.playDurition] forState:0];
            }
        });
        dispatch_resume(self.timer);
    }
    return _timeBtn;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
