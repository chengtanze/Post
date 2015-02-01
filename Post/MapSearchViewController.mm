//
//  MapSearchViewController.m
//  Post
//
//  Created by cheng on 15/1/30.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MapSearchViewController.h"
#import "BMapKit.h"
@interface MapSearchViewController ()<BMKGeneralDelegate, BMKMapViewDelegate, CLLocationManagerDelegate, BMKPoiSearchDelegate, BMKLocationServiceDelegate>
{
    CLLocation *checkinLocation;
}
@property(nonatomic, strong)BMKMapManager* mapManager;
@property(nonatomic, strong)BMKMapView *mapView;
@property(nonatomic, strong)CLLocationManager * locationManager;
@property(nonatomic, strong)BMKPoiSearch* poiSearch;

@property(nonatomic, strong)BMKLocationService* locService;//定位服务


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
    
    //[self serachPOIByCity:@"深圳" address:@"苹果园"];
    
//    self.locationManager = [[CLLocationManager alloc]init];
//    _locationManager.delegate = self;
//    self.locationManager.distanceFilter = 200;
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [self.locationManager startUpdatingLocation];
    
    
    // 代码创建 BMKMapView
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)]; // self.view.bounds.size.width, self.view.bounds.size.height将创建的 BMKMapView 添加到 View 上
//    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
//    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
//    _mapView.showsUserLocation = YES;//显示定位图层
//    //设置定位精确度，默认：kCLLocationAccuracyBest
//    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
//    [BMKLocationService setLocationDistanceFilter:100.f];
    
    
    [self.view addSubview:self.mapView];
    
    
    
    UIButton * but = [[UIButton alloc]initWithFrame:CGRectMake(0, 450, 100, 20)];
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

-(void)handleButtonTap:(id)sender{
    //[_button setSelected:YES];
    //[RadioButton buttonSelected:self];

    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}

-(void)initPOI{
    self.poiSearch = [[BMKPoiSearch alloc]init];
    self.locService = [[BMKLocationService alloc]init];

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
    
    
}

-(void)viewDidAppear:(BOOL)animated{
   // [self.locService startUserLocationService];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _poiSearch.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
}



-(BOOL)serachPOIByCity:(NSString *)city address:(NSString *)address{
    int curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= city;
    citySearchOption.keyword = address;
    BOOL flag = [self.poiSearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
    
    return flag;
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    //清除之前的数据
    [_BMKPoiInfoArray removeAllObjects];
    if (error == BMK_SEARCH_NO_ERROR) {
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            [_BMKPoiInfoArray addObject:poi];
        }
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
        NSLog(@"onGetPoiResult Error:[%d]", error);
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
//    BMKUserLocation * location = [[BMKUserLocation alloc]init];
//    location.location.coordinate.latitude = 22.287748;
//    location.location.coordinate.longitude = 114.169702;
  
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
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
