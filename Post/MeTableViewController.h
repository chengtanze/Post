//
//  MeTableViewController.h
//  Post
//
//  Created by cheng on 15/4/20.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;
@property (weak, nonatomic) IBOutlet UIView *backGroupView;


@property(assign, nonatomic) BOOL bCourierIdentity;
@end
