//
//  MapAroudViewController.m
//  Post
//
//  Created by wangsl-iMac on 15/3/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MapAroudViewController.h"
#import "MapPulicFunction.h"
#define POST_TIMER_GETUSERGPS (5.0)

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
}

//创建地图上的控件
-(void)createMapViewWidget{
    NSLog(@"createMapViewWidget");
}

//绘制用户背景图
-(void)createUserBackImage{
    NSLog(@"createUserBackImage");
    
    [self addOverlayView];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
