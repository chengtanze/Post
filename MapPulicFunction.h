//
//  MapPulicFunction.h
//  Post
//
//  Created by wangsl-iMac on 15/3/12.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface MapPulicFunction : NSObject
@property(nonatomic, strong)BMKAddressComponent* addressDetail;    //记录用户逆地理地址
@property(nonatomic, strong)BMKUserLocation * userLocation;         //记录用户gps地址

@end
