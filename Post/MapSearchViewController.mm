//
//  MapSearchViewController.m
//  Post
//
//  Created by cheng on 15/1/30.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MapSearchViewController.h"
#import "BMapKit.h"
@interface MapSearchViewController ()<BMKGeneralDelegate, BMKMapViewDelegate, CLLocationManagerDelegate, BMKPoiSearchDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
{
    CLLocation *checkinLocation;
}
@property(nonatomic, strong)BMKMapManager* mapManager;
@property(nonatomic, strong)BMKMapView *mapView;
@property(nonatomic, strong)CLLocationManager * locationManager;
@property(nonatomic, strong)BMKPoiSearch* poiSearch;

@property(nonatomic, strong)BMKLocationService* locService; //定位服务
@property(nonatomic, strong)BMKGeoCodeSearch* geoCodeSearch;//逆地理查询


//保存查询poi点信息
@property(nonatomic, strong)NSMutableArray *BMKPoiInfoArray;
@end

@implementation MapSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self initMap];
    [self initLocalData];
    [self initPOI];

    
//    self.locationManager = [[CLLocationManager alloc]init];
//    _locationManager.delegate = self;
//    self.locationManager.distanceFilter = 200;
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [self.locationManager startUpdatingLocation];
    
    
    // 代码创建 BMKMapView
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)]; // 将创建的 BMKMapView 添加到 View 上

    [self.view addSubview:self.mapView];
    
    
    
    UIButton * but = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, 100, 20)];
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}

-(void)handleButtonTap:(id)sender{
    NSLog(@"handleButtonTap");
    //[_mapView zoomIn];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
}

-(void)initPOI{
    self.poiSearch = [[BMKPoiSearch alloc]init];
    self.locService = [[BMKLocationService alloc]init];
    self.geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
}

-(void)initLocalData{
    self.BMKPoiInfoArray = [[NSMutableArray alloc]initWithCapacity:10];
}

-(void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation
          fromLocation:(CLLocation*)oldLocation{
    
    checkinLocation = newLocation;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poiSearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.locService.delegate = self;
    self.geoCodeSearch.delegate = self;
    
}

-(void)viewDidAppear:(BOOL)animated{
   // [self.locService startUserLocationService];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _poiSearch.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
    self.geoCodeSearch.delegate = nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    NSString* showmeg = [NSString stringWithFormat:@"您点击了地图空白处(blank click).\r\n当前经度:%f,当前纬度:%f,\r\nZoomLevel=%d;RotateAngle=%d;OverlookAngle=%d", coordinate.longitude,coordinate.latitude,
                         (int)_mapView.zoomLevel,_mapView.rotation,_mapView.overlooking];
    
    //isGeoSearch = false;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    
    pt = (CLLocationCoordinate2D){coordinate.latitude, coordinate.longitude};
    
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
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
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
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [_mapView updateLocationData:userLocation];
}
/*用户方向更新后，会调用此函数
*@param userLocation 新的用户位置
*/
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
