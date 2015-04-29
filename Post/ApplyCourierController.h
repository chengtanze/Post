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
- (IBAction)obverseImage:(id)sender;
- (IBAction)reverseImage:(id)sender;
- (IBAction)takeIDCardClick:(id)sender;
- (IBAction)drivingLicenseClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *obverseButton;
@property (weak, nonatomic) IBOutlet UIButton *reverserButton;
@property (weak, nonatomic) IBOutlet UIButton *takeIDCardButton;
@property (weak, nonatomic) IBOutlet UIButton *drivingLicenseBtn;


@property (strong, nonatomic) NSMutableArray * imagesArray;
//
@end
