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

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点 6：用户点
    int _degree;
    int _userTag;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@property (nonatomic) int userTag;
@end

@protocol MapFunctionDelegate <NSObject>

//获取当前用户逆地理
-(void)reverseGeoAddress:(BMKAddressComponent *)strAddress;

//根据地址信息获取gps点
-(void)GPSFromAddress:(CLLocationCoordinate2D)userLocation;

@end

@interface MapPulicFunction : NSObject
@property(nonatomic, strong)BMKAddressComponent* addressDetail;    //记录用户逆地理地址
@property(nonatomic, strong)BMKUserLocation * userLocation;         //记录用户gps地址
@property(nonatomic, weak)id<MapFunctionDelegate> delegate;

+ (MapPulicFunction *)sharedInstance;

//获取逆地理信息 （回调）
-(void)getReverseGeoAddress;

//获取指定gps的逆地理信息（回调）
-(void)getReverseGeoAddress:(CLLocationCoordinate2D)coordinate;

//根据地址信息获取gps点（回调）
-(BOOL)getGPSFromAddress:(NSString *)address city:(NSString *)city;
@end
