//
//  EditCargoInfoTableViewController.h
//  Post
//
//  Created by cheng on 15/1/31.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCargoInfoTableViewController : UITableViewController
- (IBAction)changeAddress:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *firstAddress;
@property (weak, nonatomic) IBOutlet UILabel *secondAddress;

@end
