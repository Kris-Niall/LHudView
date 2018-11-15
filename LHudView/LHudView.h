//
//  LHudView.h
//  LHudViewDemo
//
//  Created by ZERO on 2018/11/15.
//  Copyright © 2018年 com.xq.RedLetterd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHudView : UIView

//- (instancetype)init;
//- (void)showInView;

+ (void)showSuccess:(NSString *)msg;
+ (void)showError:(NSString *)msg;
+ (void)showWarning:(NSString *)msg;

+ (void)showProcess:(NSString *)msg;

+ (void)dismiss;

@end
