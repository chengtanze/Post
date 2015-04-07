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

-(NSURLSessionDataTask *)getGoodsTypeList:(void(^) (NSDictionary * data, NSError *error))block{
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/getGoodsTypeList.php?" parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject)
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

-(NSURLSessionDataTask *)addSenderOrder:(NSDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block
{
    NSString * uid = @"7";
    NSNumber * type = [[NSNumber alloc]initWithInt:0];
    NSString * name = @"鲜花";
    NSNumber * value =  [[NSNumber alloc]initWithDouble: 50.0];
    NSNumber * weight = [[NSNumber alloc]initWithDouble: 20.0];
    NSNumber * pgWay = [[NSNumber alloc]initWithInt:0];
    NSNumber * rgWay = [[NSNumber alloc]initWithInt:0];
    NSString * rgStartTime = @"2015-04-08 12:00:00";
    NSString * rgEndTime = @"2015-04-08 14:00:00";
    NSString * pgAddress = @"深圳市南山区科技园";
    NSString * rgAddress = @"深圳市南山区世界之窗";
    NSNumber * pgLongitude = [[NSNumber alloc]initWithDouble:22.00998];
    NSNumber * pgLatitude = [[NSNumber alloc]initWithDouble:121.00013];
    NSNumber * rgLongitude = [[NSNumber alloc]initWithDouble:22.00998];
    NSNumber * rgLatitude = [[NSNumber alloc]initWithDouble:121.00013];
    NSNumber * payMethod = [[NSNumber alloc]initWithInt:0];
    NSNumber * free = [[NSNumber alloc]initWithDouble:40.0];
    NSString * pgName = @"张三";
    NSString * pgPhone = @"13888888888";
    NSString * rgName = @"李四";
    NSString * rgPhone = @"13877777777";
    NSString * explanation = @"无";
    NSNumber * deliveryAID = [[NSNumber alloc]initWithInt:0755];
    NSNumber * receiveAID = [[NSNumber alloc]initWithInt:0755];
    NSNumber * deliveryCityID = [[NSNumber alloc]initWithInt:0755];
    NSNumber * receiveCityID = [[NSNumber alloc]initWithInt:0755];
    NSArray * iamges = [[NSArray alloc]initWithObjects:@"c:\\path1.jpg", @"c:\\path2.jpg", nil];
    
    NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    [paramsTest setObject: uid forKey:@"uid"];
    [paramsTest setObject: type forKey:@"type"];
    [paramsTest setObject: name forKey:@"name"];
    [paramsTest setObject: value forKey:@"value"];
    [paramsTest setObject: weight forKey:@"weight"];
    [paramsTest setObject: pgWay forKey:@"pgWay"];
    [paramsTest setObject: rgWay forKey:@"rgWay"];
    [paramsTest setObject: rgStartTime forKey:@"rgStartTime"];
    [paramsTest setObject: rgEndTime forKey:@"rgEndTime"];
    [paramsTest setObject: pgAddress forKey:@"pgAddress"];
    [paramsTest setObject: rgAddress forKey:@"rgAddress"];
    [paramsTest setObject: pgLongitude forKey:@"pgLongitude"];
    [paramsTest setObject: pgLatitude forKey:@"pgLatitude"];
    [paramsTest setObject: rgLongitude forKey:@"rgLongitude"];
    [paramsTest setObject: rgLatitude forKey:@"rgLatitude"];
    [paramsTest setObject: payMethod forKey:@"payMethod"];
    [paramsTest setObject: free forKey:@"free"];
    [paramsTest setObject: pgName forKey:@"pgName"];
    [paramsTest setObject: pgPhone forKey:@"pgPhone"];
    [paramsTest setObject: rgName forKey:@"rgName"];
    [paramsTest setObject: rgPhone forKey:@"rgPhone"];
    [paramsTest setObject: explanation forKey:@"explanation"];
    [paramsTest setObject: deliveryAID forKey:@"deliveryAID"];
    [paramsTest setObject: receiveAID forKey:@"receiveAID"];
    [paramsTest setObject: deliveryCityID forKey:@"deliveryCityID"];
    [paramsTest setObject: receiveCityID forKey:@"receiveCityID"];
    [paramsTest setObject: iamges forKey:@"iamges"];
    
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/addOrder.php?" parameters:paramsTest success:^(NSURLSessionDataTask * __unused task, id responseObject)
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
