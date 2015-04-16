//
//  HttpProtocolAPI.m
//  Post
//
//  Created by cheng on 15/4/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "HttpProtocolAPI.h"
#import "UserDataInterface.h"
#import "AFHTTPRequestOperationManager.h"
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
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/register.php?" parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject)
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
    
    NSString * uid = [UserDataInterface sharedClient].userID;
    NSString * key = [UserDataInterface sharedClient].userKey;
    
    [params setObject: uid forKey:@"uid"];
    [params setObject: @"" forKey:@"imei"];
    [params setObject: @"" forKey:@"ip"];
    [params setObject: @"" forKey:@"mac"];
    [params setObject: key forKey:@"key"];

    
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

-(NSURLSessionDataTask *)addSenderOrder:(NSMutableDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block
{
    //NSString * uid = @"7";
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
    
    NSString * uid = [UserDataInterface sharedClient].userID;
    NSString * key = [UserDataInterface sharedClient].userKey;
    
    [params setObject: uid forKey:@"uid"];
    [params setObject: @"" forKey:@"imei"];
    [params setObject: @"" forKey:@"ip"];
    [params setObject: @"" forKey:@"mac"];
    [params setObject: key forKey:@"key"];
    
    
    NSString * explanation = @"无";
    NSNumber * deliveryAID = [[NSNumber alloc]initWithInt:0755];
    NSNumber * receiveAID = [[NSNumber alloc]initWithInt:0755];
    NSNumber * deliveryCityID = [[NSNumber alloc]initWithInt:0755];
    NSNumber * receiveCityID = [[NSNumber alloc]initWithInt:0755];
    
    
    
    UIImage *image = [UIImage imageNamed:@"poi_2.png"];
   // NSData *data = UIImagePNGRepresentation(image);
    
    NSData *data = UIImageJPEGRepresentation(image, 0.7);
    NSArray * iamges = [[NSArray alloc]initWithObjects:data, nil];
    
    [params setObject: explanation forKey:@"explanation"];
    [params setObject: deliveryAID forKey:@"deliveryAID"];
    [params setObject: receiveAID forKey:@"receiveAID"];
    [params setObject: deliveryCityID forKey:@"deliveryCityID"];
    [params setObject: receiveCityID forKey:@"receiveCityID"];
    [params setObject: iamges forKey:@"iamges[]"];
    [params setObject: uid forKey:@"uid"];
    [params setObject: @"" forKey:@"imei"];
    [params setObject: @"" forKey:@"ip"];
    [params setObject: @"" forKey:@"mac"];
    [params setObject: key forKey:@"key"];
//    NSURL *url = [NSURL URLWithString:@"http://api-base-url.com"];
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
//    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"avatar.jpg"], 0.5);
//    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"/upload" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
//        [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/jpeg"];
//    }];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
//    }];  
//    [operation start];
    
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
    //[paramsTest setObject: iamges forKey:@"images[]"];
    [paramsTest setObject: uid forKey:@"uid"];
    [paramsTest setObject: @"" forKey:@"imei"];
    [paramsTest setObject: @"" forKey:@"ip"];
    [paramsTest setObject: @"" forKey:@"mac"];
    [paramsTest setObject: key forKey:@"key"];
    
    

    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    
    
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:APIBaseURLString]];
//    AFHTTPRequestOperation *op = [manager POST:@"qmld/api/addOrder.php?" parameters:paramsTest constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
////        NSData *imageData = UIImageJPEGRepresentation(image, 1);
////        
////        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
////        formatter.dateFormat = @"yyyyMMddHHmmss";
////        NSString *str = [formatter stringFromDate:[NSDate date]];
////        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
////        
////        // 上传图片，以文件流的格式
////        [formData appendPartWithFileData:imageData name:@"myfiles" fileName:fileName mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //completion(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //errorBlock(error);
//        NSLog(@"%@", error);
//    }];
//    
//    return nil;
    
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/addOrder.php?" parameters:paramsTest constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image = [UIImage imageNamed:@"poi_2.png"];
        NSData *data = UIImageJPEGRepresentation(image, 0.7);
        //NSArray * iamges = [[NSArray alloc]initWithObjects:data, nil];
        /*
         32          此方法参数
         33          1. 要上传的[二进制数据]
         34          2. 对应网站上[upload.php中]处理文件的[字段"file"]
         35          3. 要保存在服务器上的[文件名]
         36          4. 上传文件的[mimeType]
         37          */
        [formData appendPartWithFileData:data name:@"images[]" fileName:@"poi_2.png" mimeType:@"image/png"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString * xmlstring = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",xmlstring);
        NSData* data = [xmlstring dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * retDictData = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        
        if (block != nil)
        {
            block(retDictData, retError);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"%@",error);
        if (block != nil)
        {
            block(nil, error);
        }
    }];
    
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

-(NSURLSessionDataTask *)getOrders:(NSDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInt:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    
    [paramsTest setObject: userID forKey:@"uid"];
    [paramsTest setObject: @"" forKey:@"imei"];
    [paramsTest setObject: @"" forKey:@"ip"];
    [paramsTest setObject: @"" forKey:@"mac"];
    [paramsTest setObject: key forKey:@"key"];
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/getOrders.php?" parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject)
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

-(NSURLSessionDataTask *)getOrderByState:(NSUInteger)state setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInt:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    NSNumber * numberState = [[NSNumber alloc]initWithInt:state];
    
    [paramsTest setObject: userID forKey:@"uid"];
    [paramsTest setObject: @"" forKey:@"imei"];
    [paramsTest setObject: @"" forKey:@"ip"];
    [paramsTest setObject: @"" forKey:@"mac"];
    [paramsTest setObject: key forKey:@"key"];
    [paramsTest setObject: numberState forKey:@"state"];
    
    NSLog(@"uid:%@,imei:%@,ip:%@,mac:%@,key:%@,state:%@", userID, @"",@"",@"", key, numberState);
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/getOrderByState.php?" parameters:paramsTest success:^(NSURLSessionDataTask * __unused task, id responseObject)
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
