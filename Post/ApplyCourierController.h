//
//  ApplyCourierController.h
//  Post
//
//  Created by cheng on 15/3/21.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyCourierController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *ApplyTableView;
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *IDCardLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactPersonLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneCallLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;

@end
