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
    NSInteger _userID_Int;
    NSString * _userPhoneNum;
    NSString * _userKey;
    NSString * _userImageHeader;
    NSUInteger _userHonestRank;
}
+ (instancetype)sharedClient;

@property(strong, nonatomic)NSDictionary * dicUserInfo;

@property(assign, nonatomic)BOOL bLogin;
@property(strong, nonatomic)NSString * userLoginName;
@property(strong, nonatomic)NSString * userLoginPassWord;

@property(strong, nonatomic)NSString * userNickName;
@property(strong, nonatomic)NSString * userID;
@property(assign, nonatomic)NSInteger userID_Int;
@property(strong, nonatomic)NSString * userPhoneNum;
@property(strong, nonatomic)NSString * userKey;
@property(strong, nonatomic)NSString * userImageHeader;
@property(assign, nonatomic)NSUInteger userHonestRank;


-(void)saveLoginInfo:(NSString *)loginName passWord:(NSString *)loginPW;
-(NSArray *)loadLoginInfo;

@end
