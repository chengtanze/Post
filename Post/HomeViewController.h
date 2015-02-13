//
//  HomeViewController.h
//  Post
//
//  Created by wangsl-iMac on 15/1/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableView *HomeItemTableView;

@property (weak, nonatomic) IBOutlet UIView *cellForScrollView;

@end
