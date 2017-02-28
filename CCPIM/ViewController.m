//
//  ViewController.m
//  CCPIM
//
//  Created by 储诚鹏 on 17/2/28.
//  Copyright © 2017年 chuchengpeng. All rights reserved.
//

#import "ViewController.h"
#import "TalkViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *waitView;

@end


/*
 user001
 jack
 z8R4Rrx4HEM1W5Dj9QM2RAYYofz8p7x0yigxTEVxyCgVyacMpBlRQ0x5opmqubxUNKbLzOHqsLeIDykMso3NfA==
 user002
 james
 8ZIq+VyycriXE+poEnrF4sy1DYsFw7qkOJ4EfLOy4je3yrT0BhqJrkj8co9I6O2yY/gKxrEvJJSw/QeXcfVMO/rOmGxAWvWe
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.ccp.im"];
    if (token) {
        [self connectToIMWithToken:token sender:nil];
    }
    else {
        self.waitView.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

/*
 101:jack
 102:james
 */

- (IBAction)login:(UIButton *)sender {
    NSString *token;
    if (sender.tag == 101) {
        token = @"z8R4Rrx4HEM1W5Dj9QM2RAYYofz8p7x0yigxTEVxyCgVyacMpBlRQ0x5opmqubxUNKbLzOHqsLeIDykMso3NfA==";
    }
    else {
        token = @"8ZIq+VyycriXE+poEnrF4sy1DYsFw7qkOJ4EfLOy4je3yrT0BhqJrkj8co9I6O2yY/gKxrEvJJSw/QeXcfVMO/rOmGxAWvWe";
    }
    sender.enabled = NO;
    [self connectToIMWithToken:token sender:sender];
}

- (void)connectToIMWithToken:(NSString *)token sender:(UIButton *)sender {
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        sender.enabled = YES;
        [self loginSuccessWithToken:token];
        NSLog(@"login successed!the userId = %@",userId);
    } error:^(RCConnectErrorCode status) {
        //已经连接
        if (status == RC_CONNECTION_EXIST) {
            [self loginSuccessWithToken:token];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.waitView.hidden = YES;
            });
            NSLog(@"login failed!the errorCode = %ld",status);
        }
        sender.enabled = YES;
    } tokenIncorrect:^{
        NSLog(@"login failed!token is over time");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.waitView.hidden = YES;
        });
        sender.enabled = YES;
    }];
}


- (void)loginSuccessWithToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"com.ccp.im"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    dispatch_async(dispatch_get_main_queue(), ^{
        TalkViewController *talk = [[TalkViewController alloc] init];
        [self.navigationController pushViewController:talk animated:YES];
        self.waitView.hidden = YES;
    });
}

@end
