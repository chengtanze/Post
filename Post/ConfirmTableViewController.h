//
//  ConfirmTableViewController.h
//  Post
//
//  Created by cheng on 15/2/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PhotoGroupView.h"
@interface ConfirmTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topFirstSep;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSecondSep;
@property (weak, nonatomic) IBOutlet UITableViewCell *photoInfoCell;
@property (weak, nonatomic) IBOutlet UIView *PhotoGroupView;

@end
