//
//  MapSearchViewController.m
//  Post
//
//  Created by cheng on 15/1/30.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MapSearchViewController.h"
#import "inc/BMapKit.h"
@interface MapSearchViewController ()<BMKGeneralDelegate, BMKMapViewDelegate>
@property(nonatomic, strong)BMKMapManager* mapManager;
@property(nonatomic, strong)BMKMapView *mapView;
@end

@implementation MapSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self initMap];
    
    // 代码创建 BMKMapView
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)]; // self.view.bounds.size.width, self.view.bounds.size.height将创建的 BMKMapView 添加到 View 上
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置 nil,否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时,置 nil
}

-(void)initMap{
    self.mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [self.mapManager start:@"GoP581yd8LAOFZ27DNVAP7mS" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
