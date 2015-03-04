//
//  OrderTrackViewController.m
//  Post
//
//  Created by cheng on 15/2/5.
//  Copyright (c) 2015年 cheng. All rights reserved.
//




#import "OrderTrackViewController.h"
#import "BMapKit.h"
#import "OrderTrack_UserItem_Cell.h"


@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：用户点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface OrderTrackViewController () <BMKMapViewDelegate, BMKLocationServiceDelegate, UITableViewDelegate, UITableViewDataSource>
{
    BMKPolyline* polyline;
    BMKGroundOverlay* groundStart;
    BMKGroundOverlay* groundEnd;
    CGFloat TrackCellHeight;
}
@property(nonatomic, strong)UITableView * routeInfoTableView;
@property(nonatomic, strong)BMKMapView *mapView;
@property(nonatomic, strong)BMKLocationService* locService; //定位服务
@end


@implementation OrderTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单跟踪";
    // Do any additional setup after loading the view.
    
    [self initMapView];
    [self initRouteInfoTableView];
    
    
    self.locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
    long nCount = 6;
    CLLocationCoordinate2D * coors = new CLLocationCoordinate2D[nCount];
    coors[0].latitude   = 22.596281;
    coors[0].longitude  = 113.897950;
    coors[1].latitude   = 22.596208;
    coors[1].longitude  = 113.892015;
    coors[2].latitude   = 22.595651;
    coors[2].longitude  = 113.895489;
    coors[3].latitude   = 22.590456;
    coors[3].longitude  = 113.895489;
    coors[4].latitude   = 22.586119;
    coors[4].longitude  = 113.899632;
    coors[5].latitude   = 22.580852;
    coors[5].longitude  = 113.893250;
    
    [self pathPlanning:coors count:nCount];
    [self addGroundOverlay];
//    if (coors != NULL) {
//        delete [] coors;
//    }
}

-(void)initRouteInfoTableView{
    self.routeInfoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 300) style:UITableViewStylePlain];
    
    [self.view addSubview:self.routeInfoTableView];
    self.routeInfoTableView.delegate = self;
    self.routeInfoTableView.dataSource = self;
    self.routeInfoTableView.alpha = 0.8;
}

long cout = 5;
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cout;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = nil;
    
    
    if (indexPath.row == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingItem"];
        NSString * time = @"状态：派单中";
        NSString * info = @"单号：1234567890";
        cell.textLabel.text = time;
        cell.detailTextLabel.text = info;

        
    }else if(indexPath.row == 4){
        OrderTrack_UserItem_Cell * Itemcell = [[[NSBundle mainBundle] loadNibNamed:@"OrderTrack_UserItem" owner:self options:nil] objectAtIndex:0];
        
        
        Itemcell.strUserName = @"123";
        Itemcell.strUserPhone = @"123";
        [Itemcell upDateUserInfo];
        TrackCellHeight = Itemcell.userHeaderImageView.frame.size.height;
        return Itemcell;
    }
    else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SettingItem1"];
        NSString * time = @"2015-02-07 09:30:25";
        NSString * info = @"深圳市宝安区桃花源科技园";
        
        cell.textLabel.text = time;
        cell.detailTextLabel.text = info;
        
    }
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    cell.textLabel.numberOfLines = 0;
    TrackCellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    //CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    //NSLog(@"%f", height);
    
    
    return cell;
}

//根据NSIndexPath 设置指定行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"row height:%f", cellheight);
    return TrackCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"didSelectRowAtIndexPath :%ld", indexPath.row);
    
    switch (indexPath.row) {
        case 0:
        {
            //[self moveRouteInfoTableView:NO];
        }
            break;
    }
}

-(void)moveRouteInfoTableView{
    
    if (self.routeInfoTableView != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.routeInfoTableView.alpha = 0.2;
        } completion:^(BOOL finished) {
            NSLog(@"completion");
            [self.routeInfoTableView removeFromSuperview];
            self.routeInfoTableView = nil;
        }];
    }
    else{
        
        [self initRouteInfoTableView];
        
    }
}

- (IBAction)btn:(id)sender {
    [self moveRouteInfoTableView];
    //cout = 0;
    //[self.routeInfoTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    polyline = nil;
    self.locService.delegate = nil;
}


-(void)initMapView{
    // 代码创建 BMKMapView
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)]; // 将创建的 BMKMapView 添加到 View 上
    
    [self.view addSubview:self.mapView];
    _mapView.delegate = self;
    //设置地图缩放级别
    [_mapView setZoomLevel:15];
//    [_mapView removeOverlays:_mapView.overlays];
//    [_mapView removeAnnotations:_mapView.annotations];
}

- (void)addGroundOverlay {
    CLLocationCoordinate2D coorsStart;
    coorsStart.latitude = 22.596281;
    coorsStart.longitude = 113.897950;
    RouteAnnotation* itemStart = [[RouteAnnotation alloc]init];
    itemStart.coordinate = coorsStart;
    itemStart.title = @"起点";
    itemStart.type = 0;
    [_mapView addAnnotation:itemStart]; // 添加起点标注
    
    CLLocationCoordinate2D coorsEnd;
    coorsEnd.latitude = 22.580852;
    coorsEnd.longitude = 113.893250;
    RouteAnnotation* itemEnd = [[RouteAnnotation alloc]init];
    itemEnd.coordinate = coorsEnd;
    itemEnd.title = @"终点";
    itemEnd.type = 1;
    [_mapView addAnnotation:itemEnd]; // 添加起点标注
    
    CLLocationCoordinate2D coorsUser;
    coorsUser.latitude = 22.595651;
    coorsUser.longitude = 113.895489;
    RouteAnnotation* itemUser = [[RouteAnnotation alloc]init];
    itemUser.coordinate = coorsUser;
    itemUser.title = @"快递员";
    itemUser.type = 2;
    [_mapView addAnnotation:itemUser]; // 添加起点标注
    
}

-(void)pathPlanning:(CLLocationCoordinate2D *)coorsArray count:(NSUInteger)count{
    //添加折线覆盖物
    if (polyline == nil) {
        polyline = [BMKPolyline polylineWithCoordinates:coorsArray count:count];
        [_mapView addOverlay:polyline];

    }
    
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    BMKAnnotationView* AnnotationView = nil;
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        
        RouteAnnotation* routeAnnotation = (RouteAnnotation*)annotation;
        switch (routeAnnotation.type) {
            case 0:
            {
                AnnotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
                if (AnnotationView == nil) {
                    AnnotationView = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                    AnnotationView.image = [UIImage imageNamed:@"icon_nav_start.png"];//[UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                    AnnotationView.centerOffset = CGPointMake(0, -(AnnotationView.frame.size.height * 0.5));
                    AnnotationView.canShowCallout = TRUE;
                }
                AnnotationView.annotation = routeAnnotation;
                
            }
                break;
            case 1:{
                AnnotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
                if (AnnotationView == nil) {
                    AnnotationView = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                    AnnotationView.image = [UIImage imageNamed:@"icon_nav_end.png"];//[UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                    AnnotationView.centerOffset = CGPointMake(0, -(AnnotationView.frame.size.height * 0.5));
                    AnnotationView.canShowCallout = TRUE;
                }
                AnnotationView.annotation = routeAnnotation;
            }
                break;
            case 2:{
                AnnotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:@"user_node"];
                if (AnnotationView == nil) {
                    AnnotationView = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"user_node"];
                    AnnotationView.image = [UIImage imageNamed:@"icon_center_point.png"];
                    AnnotationView.centerOffset = CGPointMake(0, 0);
                    AnnotationView.canShowCallout = TRUE;
                }
                AnnotationView.annotation = routeAnnotation;
            }
                break;
        }
    }
    return AnnotationView;
}

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 4.0;
        //[polylineView loadStrokeTextureImage:[UIImage imageNamed:@"texture_arrow.png"]];
        
        return polylineView;
    }
    if ([overlay isKindOfClass:[BMKGroundOverlay class]])
    {
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
        return groundView;
    }

    return nil;
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
