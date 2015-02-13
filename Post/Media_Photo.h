//
//  Media_Photo.h  调用相册和相机
//  Post
//
//  Created by cheng on 15/2/11.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol getPhotoInfoDelegate <NSObject>

-(void)getPhoto:(UIImage *)image;

@end

@interface Media_Photo : NSObject

@property(nonatomic, weak)UIViewController * showInViewController;
@property(nonatomic, weak)id<getPhotoInfoDelegate> delegate;

- (void)chooseImage;
@end
