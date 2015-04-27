//
//  PhotoGroupTableViewCell.h
//  Post
//
//  Created by cheng on 15/2/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol photoGroupDelegate <NSObject>

-(void)selectPhotoIndex:(NSInteger)index;

@end

@interface PhotoGroupTableViewCell : UITableViewCell 

@property(nonatomic, weak)id<photoGroupDelegate> delegate;

-(void)setPhoto:(UIImage *)image byIndex:(NSInteger)index;

-(void)setURLPhoto:(NSURL *)url byIndex:(NSInteger)index;

-(void)clearPhotoGroups;
@end
