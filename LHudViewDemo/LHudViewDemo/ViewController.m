//
//  ViewController.m
//  LHudViewDemo
//
//  Created by ZERO on 2018/11/15.
//  Copyright © 2018年 com.xq.RedLetterd. All rights reserved.
//

#import "ViewController.h"
#import "LHudView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (IBAction)processAction:(id)sender {
    [LHudView showProcess:@"正在发送......"];
        double delayInSeconds = 4;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [LHudView dismiss];
        });
}

- (IBAction)successAction:(id)sender {
    [LHudView showSuccess:@"发送成功"];
}
- (IBAction)errorAction:(id)sender {
    [LHudView showError:@"发送失败"];
}
- (IBAction)warningAction:(id)sender {
    [LHudView showWarning:@"请稍后发送"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
