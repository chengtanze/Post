//
//  TaskOrderUnfinished_Address_Cell.h
//  Post
//
//  Created by cheng on 15/4/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskOrderUnfinished_Address_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startAddressLB;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLB;
- (IBAction)naviClick:(id)sender;

@end
