//
//  CCPUserInfo.h
//  CCPIM
//
//  Created by 储诚鹏 on 17/2/28.
//  Copyright © 2017年 chuchengpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCPUserInfo : NSObject<RCIMUserInfoDataSource>

@property (nonatomic, strong) RCUserInfo *user001;
@property (nonatomic, strong) RCUserInfo *user002;

@end
