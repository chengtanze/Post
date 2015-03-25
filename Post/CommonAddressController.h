//
//  CommonAddressController.h
//  Post
//
//  Created by wangsl-iMac on 15/3/23.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonAddressController : UITableViewController

@property(nonatomic, assign)NSInteger didSelectIndex;
@property(nonatomic, strong)NSMutableArray *userInfo;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end
