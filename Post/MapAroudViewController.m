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
#define POST_TIMER_GETUSERGPS (2.0)




@interface MapAroudViewController ()<MapViewDelegate>
{
    NSTimer* connectionTimer;
    BMKCircle* circle;
}

@property(nonatomic, strong)NSArray * deliveryPosision;
@property(nonatomic, strong)OrderDetailView * orderDeatailView;
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

//创建地图上的控件
-(void)createMapViewWidget{
    NSLog(@"createMapViewWidget");
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
    NSString * startAddress = @"深圳市南山区清华信息港";
    NSString * endAddress = @"深圳市南山区蛇口南海大道";
    
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
    NSString * startAddress2 = @"深圳市南山区同方信息港";
    NSString * endAddress2 = @"深圳市南山区科技园";
    
    
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
        circle = [BMKCircle circleWithCenterCoordinate:self.userLocation.location.coordinate radius:600];//
    }
    else{
        [self.mapView removeOverlay:circle];
        circle = nil;
        circle = [BMKCircle circleWithCenterCoordinate:self.userLocation.location.coordinate radius:600];
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
            itemStart.type = index;
            [self.mapView addAnnotation:itemStart]; // 添加起点标注
        }
    }
    
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    BMKAnnotationView* AnnotationView = nil;
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        
        RouteAnnotation* routeAnnotation = (RouteAnnotation*)annotation;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed:)];
        
        AnnotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
        if (AnnotationView == nil) {
            AnnotationView = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
            AnnotationView.image = [UIImage imageNamed:@"icon_nav_start.png"];//[UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
            AnnotationView.centerOffset = CGPointMake(0, -(AnnotationView.frame.size.height * 0.5));
            AnnotationView.canShowCallout = TRUE;
            AnnotationView.tag = routeAnnotation.type;
            AnnotationView.annotation = routeAnnotation;
            [AnnotationView addGestureRecognizer:tapGestureRecognizer];
        }
    }
    return AnnotationView;
}

- (void)functionButtonPressed:(UITapGestureRecognizer*)recognizer
{
    if (self.orderDeatailView == nil) {
        self.orderDeatailView = [[OrderDetailView alloc]init];
    }
    
    //填充数据
    NSDictionary * dicData = [self fillGoodsInfo:recognizer.view.tag];
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
