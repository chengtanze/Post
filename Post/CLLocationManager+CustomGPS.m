//
//  CLLocationManager+CustomGPS.m
//  Post
//
//  Created by cheng on 15/1/31.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "CLLocationManager+CustomGPS.h"
#ifdef TARGET_IPHONE_SIMULATOR
@implementation CLLocationManager (CustomGPS)
-(void)hackLocationFix
{
    //CLLocation*location=[[CLLocationalloc]initWithLatitude:42longitude:-50];
    float latitude=22.596281;
    float longitude=113.897950;//这里可以是任意的经纬度值
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.delegate locationManager:self didUpdateToLocation:location fromLocation:nil];
    //[[selfdelegate]locationManager:self didUpdateToLocation:locationfromLocation:nil];
}

-(void)startUpdatingLocation
{
    [self performSelector:@selector(hackLocationFix) withObject:nil afterDelay:0.1];
}



@end
#endif
