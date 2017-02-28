//
//  CCPUserInfo.m
//  CCPIM
//
//  Created by 储诚鹏 on 17/2/28.
//  Copyright © 2017年 chuchengpeng. All rights reserved.
//

#import "CCPUserInfo.h"

@implementation CCPUserInfo

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    if ([[userId lowercaseString] isEqualToString:@"user001"]) {
        completion(self.user001);
    }
    else {
        completion(self.user002);
    }
}

- (RCUserInfo *)user001 {
    if (!_user001) {
        _user001 = [[RCUserInfo alloc] initWithUserId:@"user001" name:@"jack" portrait:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488278848791&di=a5f6bd88fd5b26af6a00c565fe6a3278&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F19%2F66%2F66H58PICcnt_1024.jpg"];
    }
    return _user001;
}

- (RCUserInfo *)user002 {
    if (!_user002) {
        _user002 = [[RCUserInfo alloc] initWithUserId:@"user002" name:@"james" portrait:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488278848790&di=566e31a8f7282d7843e48794112426e6&imgtype=0&src=http%3A%2F%2Fpic36.nipic.com%2F20131130%2F4499633_224250411000_2.jpg"];
    }
    return _user002;
}

@end
