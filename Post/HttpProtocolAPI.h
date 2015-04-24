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

//获取货物类型
-(NSURLSessionDataTask *)getGoodsTypeList:(void(^) (NSDictionary * data, NSError *error))block;

//添加发货协议
-(NSURLSessionDataTask *)addSenderOrder:(NSMutableDictionary *)params images:(NSArray *)imageArray setBlock:(void(^) (NSDictionary * data, NSError *error))block;

//获取指定用户全部订单协议
-(NSURLSessionDataTask *)getOrders:(NSDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block;

//获取指定状态订单
-(NSURLSessionDataTask *)getOrderByState:(NSUInteger)state setBlock:(void(^) (NSDictionary * data, NSError *error))block;

//获取任务订单
-(NSURLSessionDataTask *)getTaskOrderByState:(NSUInteger)state setBlock:(void(^) (NSDictionary * data, NSError *error))block;

//根据城市获取订单（周边）
-(NSURLSessionDataTask *)getOrderByCityId:(NSUInteger)cityID setBlock:(void(^) (NSDictionary * data, NSError *error))block;

//获取用户信息
-(NSURLSessionDataTask *)getUserInfo:(NSUInteger)uID setBlock:(void(^) (NSDictionary * data, NSError *error))block;


//修改密码
-(NSURLSessionDataTask *)updatePassword:(NSMutableDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block;
@end
