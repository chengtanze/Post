//
//  UserDataInterface.h
//  Post
//  保存用户信息，包括：用户名，密码，登陆信息等
//  Created by cheng on 15/4/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataInterface : NSObject
{
    NSString * _userNickName;
    NSString * _userID;
    NSString * _userPhoneNum;
    NSString * _userKey;
    
}
+ (instancetype)sharedClient;

@property(strong, nonatomic)NSDictionary * dicUserInfo;
@property(strong, nonatomic)NSString * userNickName;
@property(strong, nonatomic)NSString * userID;
@property(strong, nonatomic)NSString * userPhoneNum;
@property(strong, nonatomic)NSString * userKey;


@end
