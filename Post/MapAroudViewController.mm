//
//  MapAroudViewController.m
//  Post
//
//  Created by wangsl-iMac on 15/3/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MapAroudViewController.h"
#import "MapPulicFunction.h"
#import "OrderDetailView.h"
#import "UIImage+Rotate.h"
#import "SelectRangeView.h"

#define POST_TIMER_GETUSERGPS (2.0)




@interface MapAroudViewController ()<MapViewDelegate, SelectRangeDelegate>
{
    NSInteger currRange;
    NSTimer* connectionTimer;
    BMKCircle* circle;
}

@property(nonatomic, strong)NSArray * deliveryPosision;
@property(nonatomic, strong)OrderDetailView * orderDeatailView;
@property(nonatomic, strong)SelectRangeView * selectRangeView;
@end

@implementation MapAroudViewController

- (void)viewDidLoad {
    self.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self addOverlayView];
    
    [self startGetUserGps];
    [self getReverseGeoAddress];
    [self analysisAroudGoodsData];
    currRange = 600;
    
    //[self NavigationPostion:@"宝安区铁岗水库" endAddress:@"宝安区凤凰岗村"];
    
    
    NSLog(@"MapAroudViewController viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self addGroundOverlay];
}

-(void)viewWillDisappear:(BOOL)animated{
    if (connectionTimer != nil) {
        [connectionTimer invalidate];
        connectionTimer = nil;
    }
    
}

-(void)startGetUserGps{
    //创建一个定时器，定时获取用户GPS
    if (connectionTimer == nil) {
        connectionTimer = [NSTimer scheduledTimerWithTimeInterval:POST_TIMER_GETUSERGPS target:self selector:@selector(timerFiredGetGps:) userInfo:nil repeats:YES];
        [connectionTimer fire];
    }



    //[self.userLocation.location addObserver:self forKeyPath:@"coordinate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionPrior|NSKeyValueObservingOptionInitial context:nil];
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if([keyPath isEqualToString:@"location"])
//    {
//        NSLog(@"observeValueForKeyPath");
//        //myLabel.text = [stockForKVO valueForKey:@"price"];
//    }
//}

-(void)timerFiredGetGps:(NSTimer *)timer{

    NSLog(@"address :%@,%@,%@", self.addressDetail.city, self.addressDetail.district, self.addressDetail.streetName);
    
    [self addOverlayView];
    //[self addGroundOverlay];
}

#define POST_MAPVIEW_ADDRESSINFO_HEIGHT (50.0)

//创建地图上的控件
-(void)createMapViewWidget{
    NSLog(@"createMapViewWidget");
    
    //定位按钮
    UIButton * but = [[UIButton alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height - POST_MAPVIEW_ADDRESSINFO_HEIGHT * 2, 20, 20)];
    [but setBackgroundImage:[UIImage imageNamed:@"fast_turn_icon"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    //范围选择按钮
    UIButton * butRange = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 30, self.view.bounds.size.height - POST_MAPVIEW_ADDRESSINFO_HEIGHT * 2, 20, 20)];
    [butRange setBackgroundImage:[UIImage imageNamed:@"over_speed_icon"] forState:UIControlStateNormal];
    [butRange addTarget:self action:@selector(handleButtonRangeTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butRange];
}

-(void)handleButtonTap:(id)sender{
    NSLog(@"handleButtonTap");

    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    self.mapView.showsUserLocation = YES;
}

-(void)handleButtonRangeTap:(id)sender{
    NSLog(@"handleButtonRangeTap");

    if (self.selectRangeView == nil) {
        self.selectRangeView = [[SelectRangeView alloc]init];
        self.selectRangeView.delegate = self;
    }
    
    [self.selectRangeView showInView:self.view];
}

//绘制用户背景图
-(void)createUserBackImage{
    NSLog(@"createUserBackImage");
    
    //[self addOverlayView];
   
}

-(void)analysisAroudGoodsData{
    //设置位置点
    CLLocationCoordinate2D coorsPoint;
    coorsPoint.latitude = 22.596281;
    coorsPoint.longitude = 113.897950;
    CGPoint point;
    point.x = coorsPoint.latitude;
    point.y = coorsPoint.longitude;
    
    NSValue *pointValue = [NSValue valueWithCGPoint:point];
    
    //设置货品名称
    NSString * goodsType = @"鲜花";
    NSString * startAddress = @"宝安区铁岗水库";
    NSString * endAddress = @"宝安区凤凰岗村";
    
    //设置距离
    NSInteger userToStartDistance = 10.1;
    NSInteger userToEndDistance = 1.2;
    CGPoint pointDistance;
    pointDistance.x = userToStartDistance;
    pointDistance.y = userToEndDistance;
    
    NSValue *valueDistance = [NSValue valueWithCGPoint:pointDistance];
    
    //设置时间
    NSString * time = @"20:26";
    
    NSDictionary * dic1 = [[NSDictionary alloc]initWithObjectsAndKeys: pointValue, @"Point", goodsType, @"goodsType", startAddress, @"startAddress", endAddress, @"endAddress", valueDistance, @"valueDistance", time, @"time", nil];
    
    CLLocationCoordinate2D coorsPoint2;
    coorsPoint2.latitude = 22.580852;
    coorsPoint2.longitude = 113.893250;
    CGPoint point2;
    point2.x = coorsPoint2.latitude;
    point2.y = coorsPoint2.longitude;
    NSValue *pointValue2 = [NSValue valueWithCGPoint:point2];
    
    //设置货品名称
    NSString * goodsType2 = @"数码产品";
    NSString * startAddress2 = @"宝安区铁岗水库";
    NSString * endAddress2 = @"宝安区丽景城";
    
    
    NSDictionary * dic2 = [[NSDictionary alloc]initWithObjectsAndKeys: pointValue2, @"Point", goodsType2, @"goodsType", startAddress2, @"startAddress", endAddress2, @"endAddress", valueDistance, @"valueDistance", time, @"time", nil];
    
    CLLocationCoordinate2D coorsPoint3;
    coorsPoint3.latitude = 22.595651;
    coorsPoint3.longitude = 113.895489;
    CGPoint point3;
    point3.x = coorsPoint3.latitude;
    point3.y = coorsPoint3.longitude;
    NSValue *pointValue3 = [NSValue valueWithCGPoint:point3];
    
    
    NSDictionary * dic3 = [[NSDictionary alloc]initWithObjectsAndKeys: pointValue3, @"Point", goodsType, @"goodsType", startAddress, @"startAddress", endAddress, @"endAddress", valueDistance, @"valueDistance", time, @"time", nil];
    
    self.deliveryPosision = [[NSArray alloc]initWithObjects:dic1, dic2, dic3, nil];
}

//添加内置覆盖物
- (void)addOverlayView {
    // 添加圆形覆盖物
     NSLog(@"addOverlayView lat %f,long %f",self.userLocation.location.coordinate.latitude,self.userLocation.location.coordinate.longitude);
    if (circle == nil) {
//        CLLocationCoordinate2D coor;
//        coor.latitude = 22.599368;
//        coor.longitude = 113.909327;
        circle = [BMKCircle circleWithCenterCoordinate:self.userLocation.location.coordinate radius:currRange];//
    }
    else{
        [self.mapView removeOverlay:circle];
        circle = nil;
        circle = [BMKCircle circleWithCenterCoordinate:self.userLocation.location.coordinate radius:currRange];
    }
    
    [self.mapView addOverlay:circle];
}

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.1];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.1];
        circleView.lineWidth = 1.0;
        
        return circleView;
    }
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    
    return nil;
}


- (void)addGroundOverlay {

    if (self.deliveryPosision != nil) {
        int nCount = self.deliveryPosision.count;
        for (int index = 0; index < nCount; index++) {
            CLLocationCoordinate2D coorsStart;
            
            NSDictionary * data = self.deliveryPosision[index];
            if (data != nil) {
                NSValue *value = [data valueForKey:@"Point"];
                CGPoint point = value.CGPointValue;
                coorsStart.latitude = point.x;
                coorsStart.longitude = point.y;
            }
            
            RouteAnnotation* itemStart = [[RouteAnnotation alloc]init];
            itemStart.coordinate = coorsStart;
            itemStart.title = @"起点";
            itemStart.type = 6;
            itemStart.userTag = index;
            [self.mapView addAnnotation:itemStart]; // 添加起点标注
        }
    }
    
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

- (void)functionButtonPressed:(UITapGestureRecognizer*)recognizer
{
    if (self.orderDeatailView == nil) {
        self.orderDeatailView = [[OrderDetailView alloc]init];
    }
    
    //填充数据
    NSDictionary * dicData = [self fillGoodsInfo:recognizer.view.tag];//
    if (dicData) {
        NSValue *value = [dicData valueForKey:@"Point"];
        //将地图焦点移动到用户选择的地方
        CLLocationCoordinate2D coorsPoint;
        coorsPoint.latitude = value.CGPointValue.x;
        coorsPoint.longitude = value.CGPointValue.y;
        [self.mapView setCenterCoordinate:coorsPoint];
        
        //地图上显示详细列表
        [self.orderDeatailView showInView:self.view];
        
        //规划路径
        [self NavigationPostion:[dicData valueForKey:@"startAddress"] endAddress:[dicData valueForKey:@"endAddress"]];
    }
    else{
        NSLog(@"数据解析错误。");
    }
    

    
    //NSLog(@"functionButtonPressed %ld", recognizer.view.tag);
}

-(NSDictionary *)fillGoodsInfo:(NSInteger)index{
    NSDictionary * dicData = self.deliveryPosision[index];
    if (dicData) {
        _orderDeatailView.goodsNameLabel.text = [dicData valueForKey:@"goodsType"];
        _orderDeatailView.goodsStartLabel.text = [dicData valueForKey:@"startAddress"];
        _orderDeatailView.goodsEndLabel.text = [dicData valueForKey:@"endAddress"];
        _orderDeatailView.timeLabel.text = [dicData valueForKey:@"time"];

        NSValue *value = [dicData valueForKey:@"valueDistance"];
        CGPoint point = value.CGPointValue;
        _orderDeatailView.toStartDistance.text = [NSString stringWithFormat:@"%.2fKM", point.x];
        _orderDeatailView.toEndDistance.text = [NSString stringWithFormat:@"%.2fKM", point.y];
    }
    
    return dicData;
}

-(void)NavigationPostion:(NSString *)startAddress endAddress:(NSString *)endAddress{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = startAddress;
    start.cityName = @"深圳市";
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = endAddress;
    end.cityName = @"深圳市";
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    BOOL flag = [self.routeSearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }
    else
    {
        NSLog(@"car检索发送失败");
    }
}

-(void)removeMapMark{
    NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];

    NSMutableArray *arrayAnnot = [[NSMutableArray alloc]initWithCapacity:array.count];
    for(int nIndex = 0; nIndex < array.count; nIndex++)
    {
        RouteAnnotation* route = array[nIndex];
        if (route != nil && route.type != 6) {
            [arrayAnnot addObject:route];
        }
    }
    
    //删除上次导航的起始标记点
    if (arrayAnnot.count > 0) {
        [self.mapView removeAnnotations:arrayAnnot];
    }
    
    //删除之前的路径规划点
    array = [NSArray arrayWithArray:self.mapView.overlays];
    [self.mapView removeOverlays:array];
}

- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    [self removeMapMark];
    
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        int size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [self.mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [self.mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [self.mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [self.mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [self.mapView addOverlay:polyLine]; // 添加路线overlay
        
        
    }
}

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];

                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
            
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.annotation = routeAnnotation;
        }
            break;
        case 6:
        {
            //RouteAnnotation* routeAnnotation = (RouteAnnotation*)routeAnnotation;
            
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed:)];
            
            view = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"user_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"user_node"];
                view.image = [UIImage imageNamed:@"icon_nav_start.png"];//[UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
                view.tag = routeAnnotation.userTag;
                view.annotation = routeAnnotation;
                [view addGestureRecognizer:tapGestureRecognizer];
            }
        }
        default:
            break;
    }
    
    return view;
}

- (void)pickerDidChaneStatus:(SelectRangeView *)picker{
    NSString * str = picker.distance;
    currRange = [str integerValue];
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
