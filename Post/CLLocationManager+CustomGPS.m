//
//  CLLocationManager+CustomGPS.m
//  Post
//
//  Created by cheng on 15/1/31.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "CLLocationManager+CustomGPS.h"

@implementation CLLocationManager (CustomGPS)
-(void)hackLocationFix
{
    //CLLocation*location=[[CLLocationalloc]initWithLatitude:42longitude:-50];
    float latitude=32.061;
    float longitude=118.79125;//这里可以是任意的经纬度值
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.delegate locationManager:self didUpdateToLocation:location fromLocation:nil];
    //[[selfdelegate]locationManager:self didUpdateToLocation:locationfromLocation:nil];
}

-(void)startUpdatingLocation
{
    [self performSelector:@selector(hackLocationFix) withObject:nil afterDelay:0.1];
}



@end
