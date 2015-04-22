//
//  UserDataInterface.m
//  Post
//  
//  Created by cheng on 15/4/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "UserDataInterface.h"

@implementation UserDataInterface
@synthesize userNickName = _userNickName;
@synthesize userID = _userID;
@synthesize userID_Int = _userID_Int;
@synthesize userPhoneNum = _userPhoneNum;
@synthesize userKey = _userKey;
@synthesize userImageHeader = _userImageHeader;
@synthesize userHonestRank = _userHonestRank;

+ (instancetype)sharedClient {
    static UserDataInterface *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[UserDataInterface alloc] init];
        _sharedClient.bLogin = NO;
    });
    
    return _sharedClient;
}

-(NSString *)userNickName{
    return (_dicUserInfo != nil ? [_dicUserInfo valueForKey:@"nickName"] : @"");
}

-(NSString *)userID{
    return (_dicUserInfo != nil ? [_dicUserInfo valueForKey:@"id"] : @"");
}

-(NSInteger)userID_Int
{
    return (_dicUserInfo != nil ? [[_dicUserInfo valueForKey:@"id"] integerValue] : -1);
}

-(NSString *) userPhoneNum{
    return (_dicUserInfo != nil ? [_dicUserInfo valueForKey:@"phoneNum"] : @"");
}

-(NSString *) userKey{
    return (_dicUserInfo != nil ? [_dicUserInfo valueForKey:@"key"] : @"");
}

-(NSString *) userImageHeader{
    return (_dicUserInfo != nil ? [_dicUserInfo valueForKey:@"avatar"] : @"");
}

-(NSUInteger) userHonestRank{
    NSUInteger nHonesRank = 0;
    
    if (_dicUserInfo != nil) {
        NSNumber * number = [_dicUserInfo valueForKey:@"honestRank"];
        nHonesRank = number.unsignedIntegerValue;
        return nHonesRank;
    }
    return nHonesRank;
}

-(void)saveLoginInfo:(NSString *)loginName passWord:(NSString *)loginPW{
    
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:loginPW forKey:@"userLoginPassWord"];
    [userDefaults setObject:loginName forKey:@"userLoginName"];
    
    _userLoginName = loginName;
    _userLoginPassWord = loginPW;
    
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
}

-(NSArray *)loadLoginInfo{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    _userLoginPassWord  = [userDefaultes stringForKey:@"userLoginPassWord"];
    _userLoginName = [userDefaultes stringForKey:@"userLoginName"];
    
    NSArray * loginInfo = [[NSArray alloc]initWithObjects:_userLoginName, _userLoginPassWord, nil];
    return loginInfo;
}

@end
