//
//  HttpProtocolAPI.h
//  Post
//
//  Created by cheng on 15/4/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface HttpProtocolAPI : AFHTTPSessionManager
+ (instancetype)sharedClient;

-(NSURLSessionDataTask *)login;
@end
