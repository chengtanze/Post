//
//  CommonDetailAddressController.h
//  Post
//
//  Created by wangsl-iMac on 15/3/25.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonDetailAddressController : UITableViewController
- (IBAction)editAddress:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *contactName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *area;
@property (weak, nonatomic) IBOutlet UITextField *detailAddress;

@property(nonatomic, strong)NSDictionary * arrInfo;

@end
