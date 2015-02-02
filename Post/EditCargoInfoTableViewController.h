//
//  EditCargoInfoTableViewController.h
//  Post
//
//  Created by cheng on 15/1/31.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedAddressViewController.h"


@interface EditCargoInfoTableViewController : UITableViewController<GetAddressTypeDelegate>
- (IBAction)changeAddress:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *firstAddress;
@property (weak, nonatomic) IBOutlet UIButton *secondAddress;

@end
