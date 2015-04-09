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
@synthesize userPhoneNum = _userPhoneNum;
@synthesize userKey = _userKey;

+ (instancetype)sharedClient {
    static UserDataInterface *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[UserDataInterface alloc] init];
    });
    
    return _sharedClient;
}

-(NSString *)userNickName{
    return (_dicUserInfo != nil ? [_dicUserInfo valueForKey:@"key"] : @"");
}

-(NSString *)userID{
    return (_dicUserInfo != nil ? [_dicUserInfo valueForKey:@"id"] : @"");
}

-(NSString *) userPhoneNum{
    return (_dicUserInfo != nil ? [_dicUserInfo valueForKey:@"phoneNum"] : @"");
}

-(NSString *) userKey{
    return (_dicUserInfo != nil ? [_dicUserInfo valueForKey:@"key"] : @"");
}

@end
