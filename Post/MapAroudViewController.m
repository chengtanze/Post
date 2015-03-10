//
//  MapAroudViewController.m
//  Post
//
//  Created by wangsl-iMac on 15/3/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MapAroudViewController.h"

@interface MapAroudViewController ()<MapViewDelegate>
{
    BMKCircle* circle;
}
@end

@implementation MapAroudViewController

- (void)viewDidLoad {
    self.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"MapAroudViewController viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建地图上的控件
-(void)createMapViewWidget{
    NSLog(@"createMapViewWidget");
}

//绘制用户背景图
-(void)createUserBackImage{
    NSLog(@"createUserBackImage");
    
    
}

//添加内置覆盖物
- (void)addOverlayView {
    // 添加圆形覆盖物
    if (circle == nil) {
        CLLocationCoordinate2D coor;
        coor.latitude = 39.915;
        coor.longitude = 116.404;
        circle = [BMKCircle circleWithCenterCoordinate:coor radius:600];
    }
    [self.mapView addOverlay:circle];
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
