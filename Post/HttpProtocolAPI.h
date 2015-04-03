//
//  HttpProtocolAPI.h
//  Post
//  协议类，各种协议都在这里定义
//  Created by cheng on 15/4/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface HttpProtocolAPI : AFHTTPSessionManager
+ (instancetype)sharedClient;

//用户登陆协议
-(NSURLSessionDataTask *)login:(NSDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block;

//用户注册协议
-(NSURLSessionDataTask *)registerUser:(NSDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block;


//获取验证码
-(NSURLSessionDataTask *)getAuthCode:(NSString *)phoneNum authType:(NSUInteger)type setBlock:(void(^) (NSDictionary * data, NSError *error))block;

@end
