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
    
    if(type != 0){
        NSString * uid = [UserDataInterface sharedClient].userID;
        NSString * key = [UserDataInterface sharedClient].userKey;
        
        [params setObject: uid forKey:@"uid"];
        [params setObject: @"" forKey:@"imei"];
        [params setObject: @"" forKey:@"ip"];
        [params setObject: @"" forKey:@"mac"];
        [params setObject: key forKey:@"key"];
    }
    
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

-(NSURLSessionDataTask *)addSenderOrder:(NSMutableDictionary *)params images:(NSArray *)imageArray setBlock:(void(^) (NSDictionary * data, NSError *error))block
{
    NSString * uid = [UserDataInterface sharedClient].userID;
    NSString * key = [UserDataInterface sharedClient].userKey;
    
    NSString * explanation = @"无";
    NSNumber * deliveryAID = [[NSNumber alloc]initWithInt:77];
    NSNumber * receiveAID = [[NSNumber alloc]initWithInt:77];
    NSNumber * deliveryCityID = [[NSNumber alloc]initWithInt:77];
    NSNumber * receiveCityID = [[NSNumber alloc]initWithInt:77];
    
    
    
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
    [paramsTest setObject: uid forKey:@"uid"];
    [paramsTest setObject: @"" forKey:@"imei"];
    [paramsTest setObject: @"" forKey:@"ip"];
    [paramsTest setObject: @"" forKey:@"mac"];
    [paramsTest setObject: key forKey:@"key"];
    
    
    
//    NSNumber * free = [[NSNumber alloc]initWithDouble:40.0];
//    NSNumber * pgLongitude = [[NSNumber alloc]initWithDouble:22.00998];
//    NSNumber * pgLatitude = [[NSNumber alloc]initWithDouble:121.00013];
//    NSNumber * rgLongitude = [[NSNumber alloc]initWithDouble:22.00998];
//    NSNumber * rgLatitude = [[NSNumber alloc]initWithDouble:121.00013];
    
    [params setObject: free forKey:@"free"];
    [params setObject: pgLongitude forKey:@"pgLongitude"];
    [params setObject: pgLatitude forKey:@"pgLatitude"];
    [params setObject: rgLongitude forKey:@"rgLongitude"];
    [params setObject: rgLatitude forKey:@"rgLatitude"];
    
    
    [params setObject: explanation forKey:@"explanation"];
    [params setObject: deliveryAID forKey:@"deliveryAID"];
    [params setObject: receiveAID forKey:@"receiveAID"];
    [params setObject: deliveryCityID forKey:@"deliveryCityID"];
    [params setObject: receiveCityID forKey:@"receiveCityID"];
    
    [params setObject: uid forKey:@"uid"];
    [params setObject: @"" forKey:@"imei"];
    [params setObject: @"" forKey:@"ip"];
    [params setObject: @"" forKey:@"mac"];
    [params setObject: key forKey:@"key"];

    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/addOrder.php?" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int nIndex = 0; nIndex < imageArray.count; nIndex++) {
            UIImage * image = imageArray[nIndex];
            NSData *data = UIImageJPEGRepresentation(image, 0.2);
            
            NSString * imageName = [NSString stringWithFormat:@"%d.png", nIndex];
            [formData appendPartWithFileData:data name:@"images[]" fileName:imageName mimeType:@"image/png"];
        }
       
        /*
         32          此方法参数
         33          1. 要上传的[二进制数据]
         34          2. 对应网站上[upload.php中]处理文件的[字段"file"]
         35          3. 要保存在服务器上的[文件名]
         36          4. 上传文件的[mimeType]
         37          */
        //[formData appendPartWithFileData:data name:@"images[]" fileName:@"poi_2.png" mimeType:@"image/png"];
        
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
        NSLog(@"addSenderOrder Error:%@",error);
        if (block != nil)
        {
            block(nil, error);
        }
    }];
    
//    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/addOrder.php?" parameters:paramsTest success:^(NSURLSessionDataTask * __unused task, id responseObject)
//            {
//                NSString * xmlstring = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                NSLog(@"%@",xmlstring);
//                NSData* data = [xmlstring dataUsingEncoding:NSUTF8StringEncoding];
//                NSDictionary * retDictData = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
//                
//                if (block != nil)
//                {
//                    block(retDictData, retError);
//                }
//                
//            } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
//                if (block != nil)
//                {
//                    block(nil, error);
//                }
//            }];
//    return nil;
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
    NSNumber * userID = [[NSNumber alloc]initWithInteger:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    NSNumber * numberState = [[NSNumber alloc]initWithInteger:state];
    
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

-(NSURLSessionDataTask *)getTaskOrderByState:(NSUInteger)state setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInteger:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    NSNumber * numberState = [[NSNumber alloc]initWithInteger:state];
    
    [paramsTest setObject: userID forKey:@"uid"];
    [paramsTest setObject: @"" forKey:@"imei"];
    [paramsTest setObject: @"" forKey:@"ip"];
    [paramsTest setObject: @"" forKey:@"mac"];
    [paramsTest setObject: key forKey:@"key"];
    [paramsTest setObject: numberState forKey:@"state"];
    
    NSLog(@"uid:%@,imei:%@,ip:%@,mac:%@,key:%@,state:%@", userID, @"",@"",@"", key, numberState);
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/getTaskOrderByState.php?" parameters:paramsTest success:^(NSURLSessionDataTask * __unused task, id responseObject)
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


-(NSURLSessionDataTask *)getOrderByCityId:(NSUInteger)cityID setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    NSError * retError = nil;
    NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInteger:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    NSNumber * numbercityID = [[NSNumber alloc]initWithInteger:cityID];
    
    [paramsTest setObject: userID forKey:@"uid"];
    [paramsTest setObject: @"" forKey:@"imei"];
    [paramsTest setObject: @"" forKey:@"ip"];
    [paramsTest setObject: @"" forKey:@"mac"];
    [paramsTest setObject: key forKey:@"key"];
    [paramsTest setObject: numbercityID forKey:@"cityId"];
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/getOrderByCityId.php?" parameters:paramsTest success:^(NSURLSessionDataTask * __unused task, id responseObject)
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

-(NSURLSessionDataTask *)getUserInfo:(NSUInteger)uID setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    NSError * retError = nil;
    NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInteger:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    
    [paramsTest setObject: userID forKey:@"uid"];
    [paramsTest setObject: @"" forKey:@"imei"];
    [paramsTest setObject: @"" forKey:@"ip"];
    [paramsTest setObject: @"" forKey:@"mac"];
    [paramsTest setObject: key forKey:@"key"];
    
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/getUserInfo.php?" parameters:paramsTest success:^(NSURLSessionDataTask * __unused task, id responseObject)
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

-(NSURLSessionDataTask *)updatePassword:(NSMutableDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    //NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInt:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    
    [params setObject: userID forKey:@"uid"];
    [params setObject: @"" forKey:@"imei"];
    [params setObject: @"" forKey:@"ip"];
    [params setObject: @"" forKey:@"mac"];
    [params setObject: key forKey:@"key"];
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/updatePassword.php?" parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject)
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

-(NSURLSessionDataTask *)addTransfer:(NSMutableDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSError * retError = nil;
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInt:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    
    [params setObject: userID forKey:@"uid"];
    [params setObject: @"" forKey:@"imei"];
    [params setObject: @"" forKey:@"ip"];
    [params setObject: @"" forKey:@"mac"];
    [params setObject: key forKey:@"key"];
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/addTransfer.php?" parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject)
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

-(NSURLSessionDataTask *)updateOrderDeliveryState:(NSUInteger)state orderID:(NSUInteger)orderID setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    NSError * retError = nil;
    NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInteger:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    NSNumber * numberState = [[NSNumber alloc]initWithUnsignedInteger:state];
    NSNumber * numberOrderID = [[NSNumber alloc]initWithUnsignedInteger:orderID];
    
    
    
    [paramsTest setObject: userID forKey:@"uid"];
    [paramsTest setObject: @"" forKey:@"imei"];
    [paramsTest setObject: @"" forKey:@"ip"];
    [paramsTest setObject: @"" forKey:@"mac"];
    [paramsTest setObject: key forKey:@"key"];
    [paramsTest setObject:numberState forKey:@"deliveryState"];
    [paramsTest setObject:numberOrderID forKey:@"orderID"];
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/updateOrderDeliveryState.php?" parameters:paramsTest success:^(NSURLSessionDataTask * __unused task, id responseObject)
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

-(NSURLSessionDataTask *)updateOrderDeliveryState:(NSMutableDictionary *)params setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    NSError * retError = nil;
    //NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInteger:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
//    NSNumber * numberState = [[NSNumber alloc]initWithUnsignedInteger:state];
//    NSNumber * numberOrderID = [[NSNumber alloc]initWithUnsignedInteger:orderID];
    
    
    
    [params setObject: userID forKey:@"uid"];
    [params setObject: @"" forKey:@"imei"];
    [params setObject: @"" forKey:@"ip"];
    [params setObject: @"" forKey:@"mac"];
    [params setObject: key forKey:@"key"];
    //[params setObject:numberState forKey:@"deliveryState"];
    //[params setObject:numberOrderID forKey:@"orderID"];
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/updateOrderDeliveryState.php?" parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject)
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

-(NSURLSessionDataTask *)addValidateImg:(NSArray *)imageArray orderID:(NSUInteger)orderID setBlock:(void(^) (NSDictionary * data, NSError *error))block{
    
    [HttpProtocolAPI sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    NSError * retError = nil;
    NSMutableDictionary * paramsTest= [[NSMutableDictionary alloc]init];
    
    NSInteger uid = [UserDataInterface sharedClient].userID_Int;
    NSNumber * userID = [[NSNumber alloc]initWithInteger:uid];
    NSString * key = [UserDataInterface sharedClient].userKey;
    NSNumber * numberOrderID = [[NSNumber alloc]initWithUnsignedInteger:orderID];
    
    [paramsTest setObject: userID forKey:@"uid"];
    [paramsTest setObject: @"" forKey:@"imei"];
    [paramsTest setObject: @"" forKey:@"ip"];
    [paramsTest setObject: @"" forKey:@"mac"];
    [paramsTest setObject: key forKey:@"key"];
    [paramsTest setObject:numberOrderID forKey:@"orderID"];
    
    return [[HttpProtocolAPI sharedClient] POST:@"qmld/api/addValidateImg.php?" parameters:paramsTest constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int nIndex = 0; nIndex < imageArray.count; nIndex++) {
            UIImage * image = imageArray[nIndex];
            NSData *data = UIImageJPEGRepresentation(image, 0.2);
            
            NSString * imageName = [NSString stringWithFormat:@"%d.png", nIndex];
            [formData appendPartWithFileData:data name:@"images[]" fileName:imageName mimeType:@"image/png"];
        }
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
        NSLog(@"addSenderOrder Error:%@",error);
        if (block != nil)
        {
            block(nil, error);
        }
    }];

}


-(NSURLSessionDataTask *)checkPhoneNum:(void(^) (NSDictionary * data, NSError *error))block{
    return nil;
}


@end
