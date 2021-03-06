//
//  MapViewController.h
//  Post
//
//  Created by wangsl-iMac on 15/3/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "BMapKit.h"

@protocol MapViewDelegate <NSObject>

//创建地图上的控件
-(void)createMapViewWidget;

//绘制用户背景图
-(void)createUserBackImage;

//获取当前用户逆地理

@end

@interface MapViewController : UIViewController


@property(nonatomic, strong)BMKMapManager* mapManager;
@property(nonatomic, strong)CLLocationManager * locationManager;
@property(nonatomic, strong)BMKPoiSearch* poiSearch;
@property(nonatomic, strong)BMKLocationService* locService;         //定位服务
@property(nonatomic, strong)BMKGeoCodeSearch* geoCodeSearch;        //逆地理查询
@property(nonatomic, strong)BMKRouteSearch *routeSearch;            //路径导航

@property(nonatomic, strong)BMKAddressComponent* addressDetail;     //记录用户逆地理地址
@property(nonatomic, strong)BMKUserLocation * userLocation;         //记录用户gps地址
@property(nonatomic, weak)id<MapViewDelegate> delegate;
@property(nonatomic, strong)BMKMapView *mapView;
-(void)getReverseGeoAddress;

@end
