//
//  PhotoGroupView.h
//  Post
//
//  Created by cheng on 15/2/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoGroupViewDelegate <NSObject>

-(void)selectPhotoIndex:(NSInteger)index;

@end

@interface PhotoGroupView : UIView
@property(nonatomic, strong)NSMutableArray * photoArray;

@property(weak, nonatomic) id<PhotoGroupViewDelegate> delegate;

-(void)setPhoto:(UIImage *)image byIndex:(NSInteger)index;

-(void)setURLPhoto:(NSURL *)url byIndex:(NSInteger)index;
@end
