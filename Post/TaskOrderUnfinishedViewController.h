//
//  TaskOrderUnfinishedViewController.h
//  Post
//
//  Created by cheng on 15/3/8.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TaskOrderUnfinishedDelegate <NSObject>

-(void)reLoadData;

@end

@interface TaskOrderUnfinishedViewController : UITableViewController
@property(strong, nonatomic)NSArray * arrayOrderUnfinishedData;
@property(assign, nonatomic)NSInteger selectIndex;

@end
