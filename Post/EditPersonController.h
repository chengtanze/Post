//
//  EditPersonController.h
//  Post
//
//  Created by wangsl-iMac on 15/3/31.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPersonController : UITableViewController
- (IBAction)goBackClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLB;

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;

@end
