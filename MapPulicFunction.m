//
//  MapPulicFunction.m
//  Post
//
//  Created by wangsl-iMac on 15/3/12.
//  Copyright (c) 2015年 cheng. All rights reserved.
//


#import "MapPulicFunction.h"

static MapPulicFunction *sharedObj = nil; //第一步：静态实例，并初始化。

@interface MapPulicFunction ()<BMKGeneralDelegate, BMKMapViewDelegate, CLLocationManagerDelegate, BMKPoiSearchDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, UISearchBarDelegate>
{
    CLLocation *checkinLocation;
    BOOL bGetGeo;
}

@property(nonatomic, strong)BMKMapManager* mapManager;

@property(nonatomic, strong)CLLocationManager * locationManager;
@property(nonatomic, strong)BMKPoiSearch* poiSearch;

@property(nonatomic, strong)BMKLocationService* locService; //定位服务
@property(nonatomic, strong)BMKGeoCodeSearch* geoCodeSearch;//逆地理查询

@end

@implementation MapPulicFunction

+ (MapPulicFunction *)sharedInstance  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

- (id)init
{
    @synchronized(self) {
        if(self = [super init])//往往放一些要初始化的变量.
        {
            [self initPOI];
        }
        return self;
    }
}

-(void)initPOI{
    self.poiSearch = [[BMKPoiSearch alloc]init];
    self.locService = [[BMKLocationService alloc]init];
    self.geoCodeSearch = [[BMKGeoCodeSearch alloc]init];

    
    [self startGetGps];
}

-(void)startGetGps{
    self.locService.delegate = self;
    self.geoCodeSearch.delegate = self;
    self.poiSearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    [_locService startUserLocationService];
}

-(void)stopGetGps{
    self.locService.delegate = nil;
    self.geoCodeSearch.delegate = nil;
    self.poiSearch.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [_locService stopUserLocationService];
}


-(void)reverseGeoSearch:(CLLocationCoordinate2D)pt{
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [self.geoCodeSearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {

        self.addressDetail = result.addressDetail;
    }
}

-(void)getReverseGeoAddress{
    [self reverseGeoSearch:_userLocation.location.coordinate];
}

-(void)getReverseGeoAddress:(CLLocationCoordinate2D)coordinate{
    [self reverseGeoSearch:coordinate];
}

/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError{
    NSLog(@"onGetNetworkState %d", iError);
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError{
    NSLog(@"onGetPermissionState %d", iError);
    
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    self.userLocation = userLocation;
    //[_mapView updateLocationData:userLocation];
}
/*用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //[_mapView updateLocationData:userLocation];
    // NSLog(@"heading is %@",userLocation.heading);
}
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}


/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error:[%ld]", (long)error.code);
}


@end
