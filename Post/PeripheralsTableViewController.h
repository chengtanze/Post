//
//  PeripheralsTableViewController.h
//  Post
//
//  Created by wangsl-iMac on 15/3/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskOrderUnfinishedViewController.h"

@interface PeripheralsTableViewController : UITableViewController

@property(strong, nonatomic)NSArray * arrayAroundData;
@property(weak, nonatomic) id<TaskOrderUnfinishedDelegate> delegate;
@end
