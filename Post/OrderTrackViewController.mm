//
//  OrderTrackViewController.m
//  Post
//
//  Created by cheng on 15/2/5.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderTrackViewController.h"
#import "BMapKit.h"

@interface OrderTrackViewController () <BMKMapViewDelegate>
{
    BMKPolyline* polyline;
}
@property(nonatomic, strong)BMKMapView *mapView;

@end

//latitude==22.596281,longitude==113.897950
//latitude==22.596208,longitude==113.892015
//latitude==22.595651,longitude==113.890199
//latitude==22.590456,longitude==113.895489
//latitude==22.586119,longitude==113.899632
//latitude==22.580852,longitude==113.893250

@implementation OrderTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initMapView];
    
    
    
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
    
//    if (coors != NULL) {
//        delete [] coors;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    polyline = nil;
}


-(void)initMapView{
    // 代码创建 BMKMapView
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)]; // 将创建的 BMKMapView 添加到 View 上
    
    [self.view addSubview:self.mapView];
    _mapView.delegate = self;
    //设置地图缩放级别
    [_mapView setZoomLevel:11];
//    [_mapView removeOverlays:_mapView.overlays];
//    [_mapView removeAnnotations:_mapView.annotations];
}

-(void)pathPlanning:(CLLocationCoordinate2D *)coorsArray count:(NSUInteger)count{
    //添加折线覆盖物
    if (polyline == nil) {

        CLLocationCoordinate2D coors[6] = {0};
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
        polyline = [BMKPolyline polylineWithCoordinates:coors count:6];
        [_mapView addOverlay:polyline];
        

    }
    
}

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    NSLog(@"123");
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 20.0;
        //[polylineView loadStrokeTextureImage:[UIImage imageNamed:@"texture_arrow.png"]];
        
        return polylineView;
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
