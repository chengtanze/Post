//
//  HttpProtocolAPI.m
//  Post
//
//  Created by cheng on 15/4/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "HttpProtocolAPI.h"

//http://114.215.132.245/qmkd_server/api
static NSString * const APIBaseURLString = @"http://114.215.132.245/";
@implementation HttpProtocolAPI

+ (instancetype)sharedClient {
    static HttpProtocolAPI *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HttpProtocolAPI alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

-(NSURLSessionDataTask *)login:(NSDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    //http://114.215.132.245/qmld/api/login.php?phoneNum=18576430783&password=123456&imei=123456&ip=192.168.0.26
//    NSString * phoneNum = @"18576430783";
//    NSString * password = @"123456";
//    NSString * imei = @"12345678";
//    NSString * ip = @"192.168.0.26";
    
    //NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
//    [params setObject: phoneNum forKey:@"phoneNum"];
//    [params setObject: password forKey:@"password"];
//    [params setObject: imei forKey:@"imei"];
//    [params setObject: ip forKey:@"ip"];
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/login.php?" parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject)
    {
        NSString * xmlstring = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",xmlstring);
        NSData* data = [xmlstring dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * retDictData = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        
        if (block != nil)
        {
            block(retDictData, retError);
        }
      
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block != nil)
        {
            block(nil, error);
        }
    }];
}

-(NSURLSessionDataTask *)registerUser:(NSDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/login.php?" parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject)
            {
                NSString * xmlstring = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"%@",xmlstring);
                NSData* data = [xmlstring dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary * retDictData = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                
                if (block != nil)
                {
                    block(retDictData, retError);
                }
                
            } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                if (block != nil)
                {
                    block(nil, error);
                }
            }];
}

-(NSURLSessionDataTask *)getAuthCode:(NSString *)phoneNum authType:(NSUInteger)type setBlock:(void(^) (NSDictionary * data, NSError *error))block
{
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    
    NSNumber * numberType = [[NSNumber alloc]initWithInt:type];
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: phoneNum forKey:@"phoneNum"];
    [params setObject: numberType forKey:@"type"];
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/getVerifyCode.php?" parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject)
            {
                NSString * xmlstring = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"%@",xmlstring);
                NSData* data = [xmlstring dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary * retDictData = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                
                if (block != nil)
                {
                    block(retDictData, retError);
                }
                
            } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                if (block != nil)
                {
                    block(nil, error);
                }
            }];
    return nil;
}





@end
