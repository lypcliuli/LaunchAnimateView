//
//  LLAppDelegate.m
//  LaunchAnimateView
//
//  Created by lypcliuli on 03/23/2018.
//  Copyright (c) 2018 lypcliuli. All rights reserved.
//

#import "LLAppDelegate.h"
#import "LLViewController.h"
#import "LaunchAnimateView.h"

@interface LLAppDelegate ()

@property (nonatomic, strong) LaunchAnimateView *animateView;

@end

@implementation LLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[LLViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    // 注意:一定要在[self.window makeKeyAndVisible]之后添加 这样的效果是先展示启动图，启动图结束之后展示动画图
    [self.window addSubview:self.animateView];
    [self.window bringSubviewToFront:self.animateView];
    
    // Override point for customization after application launch.
    return YES;
}

- (LaunchAnimateView *)animateView {
    if (!_animateView) {
        _animateView = [[LaunchAnimateView alloc] initWithFrame:self.window.bounds];
        _animateView.backgroundColor = [UIColor whiteColor];
        //        [_animateView configAnimateImg:@"7" position:CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height)];
        //        [_animateView configAnimateImgUrl:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1521782669&di=cbdd9d2877c5f42c20886031eb16858d&src=http://p2.gexing.com/G1/M00/DE/CC/rBACE1OtbgOgJjrsAAIUK1an7OA034.jpg" position:CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height)];
        _animateView.isRepeatPlay = YES;
        _animateView.playDurition = 6;
        [_animateView configAnimateVideoUrl:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4" position:CGRectMake(0, 0, self.window.bounds.size.width, self.window.bounds.size.height)];
    }
    return _animateView;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
