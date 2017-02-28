//
//  TalkViewController.m
//  CCPIM
//
//  Created by 储诚鹏 on 17/2/28.
//  Copyright © 2017年 chuchengpeng. All rights reserved.
//

#import "TalkViewController.h"
#import "PersonViewController.h"

@interface TalkViewController ()

@end

@implementation TalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    self.conversationListTableView.tableFooterView = [UIView new];
    self.showConnectingStatusOnNavigatorBar = YES;
    self.isShowNetworkIndicatorView = YES;
    self.title = @"chart list";
    [self setNav];
}

- (void)setNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"login out" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUser)];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
   
}

- (void)back {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"com.ccp.im"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[RCIM sharedRCIM] logout];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addUser {
    NSString *userid = @"user001";
    NSString *name = @"jack";
    if ([[[RCIMClient sharedRCIMClient] currentUserInfo].userId isEqualToString:userid]) {
        userid = @"user002";
        name = @"james";
    }
    PersonViewController *person = [[PersonViewController alloc] init];
    person.conversationType = ConversationType_PRIVATE;
    person.targetId = userid;
    person.title = userid;
    [self.navigationController pushViewController:person animated:YES];
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    PersonViewController *conversationVC = [[PersonViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

@end
