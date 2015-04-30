//
//  TransferInfoViewController.h
//  Post
//
//  Created by cheng on 15/4/30.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferInfoViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *choseTransfer;
@property (weak, nonatomic) IBOutlet UITableViewCell *transferCell;
- (IBAction)timePickerClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *timePickerBtn;

@end
