//
//  CLLocationManager+CustomGPS.h
//  Post
//
//  Created by cheng on 15/1/31.
//  Copyright (c) 2015年 cheng. All rights reserved.
//  模拟GPS

#import <CoreLocation/CoreLocation.h>
#ifdef TARGET_IPHONE_SIMULATOR 
@interface CLLocationManager (CustomGPS)

@end
#endif // TARGET_IPHONE_SIMULATOR