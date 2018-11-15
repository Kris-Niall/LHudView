//
//  LHudView.m
//  LHudViewDemo
//
//  Created by ZERO on 2018/11/15.
//  Copyright © 2018年 com.xq.RedLetterd. All rights reserved.
//

#import "LHudView.h"

#define HX_UI_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 判断iPhone X
#define HX_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPHoneXr
#define HX_Is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !HX_UI_IS_IPAD : NO)

//判断iPHoneXs
#define HX_Is_iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !HX_UI_IS_IPAD : NO)

//判断iPhoneXs Max
#define HX_Is_iPhoneXS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !HX_UI_IS_IPAD : NO)

#define HX_IS_IPhoneX_All (HX_Is_iPhoneX || HX_Is_iPhoneXR || HX_Is_iPhoneXS || HX_Is_iPhoneXS_MAX)

#define hxHudHeight (HX_IS_IPhoneX_All ? 94 : 70)

#define fas 34

@interface LHudView()

@property (nonatomic, strong, readonly) UIWindow *bgWindow;

@property (strong, nonatomic) UIView *stateView;
@property (strong, nonatomic) UILabel *stateLabel;

@end

@implementation LHudView

@synthesize bgWindow;

+ (LHudView*)sharedView {
    static dispatch_once_t once;
    static LHudView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[LHudView alloc] init]; });
    return sharedView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, hxHudHeight);
        
        [self addSubview:self.stateView];
        [self.stateView addSubview:self.stateLabel];
    }
    return self;
}


+ (void)dismiss{
    [[LHudView sharedView] dismissHud];
}

+ (void)showWarning:(NSString *)msg{
    [[LHudView sharedView] showWarningHud:msg];
}

+ (void)showError:(NSString *)msg{
    [[LHudView sharedView] showErrorHud:msg];
}

+ (void)showSuccess:(NSString *)msg{
    [[LHudView sharedView] showSuccessHud:msg];
}



+ (void)showProcess:(NSString *)msg{
    [[LHudView sharedView] showProcessHud:msg];
}

#pragma mark - Master show/dismiss methods



- (void)showSuccessHud:(NSString *)msg{
    self.stateLabel.text = msg;
    self.stateView.backgroundColor = [UIColor colorWithRed:59/255.0 green:210/255.0  blue:153/255.0 alpha:1.000];
    
    self.frame = CGRectMake(0, -hxHudHeight, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
    
    double delayInSeconds = 2; // 2秒后
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissHud];
    });
    [self.bgWindow addSubview:self];
    [self.bgWindow makeKeyAndVisible];
}

- (void)showErrorHud:(NSString *)msg{
    self.stateLabel.text = msg;
    self.stateView.backgroundColor = [UIColor blackColor];
    
    self.frame = CGRectMake(0, -hxHudHeight, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
    
    double delayInSeconds = 2; // 2秒后
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissHud];
    });
    [self.bgWindow addSubview:self];
    [self.bgWindow makeKeyAndVisible];
}

- (void)showWarningHud:(NSString *)msg{
    self.stateLabel.text = msg;
    self.stateView.backgroundColor = [UIColor colorWithRed:41/255.0 green:199/255.0  blue:244/255.0 alpha:1.000];
    
    self.frame = CGRectMake(0, -hxHudHeight, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
    
    double delayInSeconds = 2; // 2秒后异步执行
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissHud];
    });
    [self.bgWindow addSubview:self];
    [self.bgWindow makeKeyAndVisible];
}


- (void)showProcessHud:(NSString *)msg{
    self.frame = CGRectMake(0, -hxHudHeight, self.frame.size.width, self.frame.size.height);
    self.stateView.backgroundColor = [UIColor colorWithRed:41/255.0 green:199/255.0  blue:244/255.0 alpha:1.000];
    self.stateLabel.text = msg;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
    [self.bgWindow addSubview:self];
    [self.bgWindow makeKeyAndVisible];
    
}

- (void)dismissHud{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, -hxHudHeight, self.frame.size.width, self.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
                         [windows removeObject:self->bgWindow];
                         self->bgWindow = nil;
                         
                         [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
                             if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
                                 [window makeKeyWindow];
                                 *stop = YES;
                             }
                         }];
                         
                     }];
    
}



- (UIWindow *)bgWindow{
    if (!bgWindow) {
        bgWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        bgWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        bgWindow.backgroundColor = [UIColor clearColor];
        //                bgWindow.alpha = 0.3;
        
        bgWindow.userInteractionEnabled = YES;
        
    }
    
    return bgWindow;
}


- (UIView *)stateView{
    if (!_stateView) {
        _stateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, hxHudHeight)];
        
        _stateView.backgroundColor = [UIColor blackColor];
    }
    return _stateView;
}


- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, hxHudHeight - 50, [UIScreen mainScreen].bounds.size.width, 50)];
        _stateLabel.textAlignment = 1;
        _stateLabel.font = [UIFont systemFontOfSize:14];
        _stateLabel.textColor = [UIColor whiteColor];
        //        _stateLabel.text = @"发送失败，请检查网络";
    }
    return _stateLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
