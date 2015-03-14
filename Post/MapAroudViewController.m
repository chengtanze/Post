//
//  MapAroudViewController.m
//  Post
//
//  Created by wangsl-iMac on 15/3/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MapAroudViewController.h"
#import "MapPulicFunction.h"

#define POST_TIMER_GETUSERGPS (2.0)




@interface MapAroudViewController ()<MapViewDelegate>
{
    NSTimer* connectionTimer;
    BMKCircle* circle;
}
@end

@implementation MapAroudViewController

- (void)viewDidLoad {
    self.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self addOverlayView];
    
    
    
    [self startGetUserGps];
    [self getReverseGeoAddress];
    
    
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
        //circle.coordinate = self.userLocation.location.coordinate;
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
    CLLocationCoordinate2D coorsStart;
    coorsStart.latitude = 22.596281;
    coorsStart.longitude = 113.897950;
    RouteAnnotation* itemStart = [[RouteAnnotation alloc]init];
    itemStart.coordinate = coorsStart;
    itemStart.title = @"起点";
    itemStart.type = 0;
    [self.mapView addAnnotation:itemStart]; // 添加起点标注
    
    CLLocationCoordinate2D coorsEnd;
    coorsEnd.latitude = 22.580852;
    coorsEnd.longitude = 113.893250;
    RouteAnnotation* itemEnd = [[RouteAnnotation alloc]init];
    itemEnd.coordinate = coorsEnd;
    itemEnd.title = @"终点";
    itemEnd.type = 1;
    [self.mapView addAnnotation:itemEnd]; // 添加起点标注
    
    CLLocationCoordinate2D coorsUser;
    coorsUser.latitude = 22.595651;
    coorsUser.longitude = 113.895489;
    RouteAnnotation* itemUser = [[RouteAnnotation alloc]init];
    itemUser.coordinate = coorsUser;
    itemUser.title = @"快递员";
    itemUser.type = 2;
    [self.mapView addAnnotation:itemUser]; // 添加起点标注
    
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    BMKAnnotationView* AnnotationView = nil;
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        
        RouteAnnotation* routeAnnotation = (RouteAnnotation*)annotation;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
        
        switch (routeAnnotation.type)
        {
            case 0:
            {
                AnnotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
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
                AnnotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
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
                AnnotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"user_node"];
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
        
        [AnnotationView addGestureRecognizer:tapGestureRecognizer];
    }
    return AnnotationView;
}

- (void)functionButtonPressed
{
    NSLog(@"functionButtonPressed");
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
