//
//  OrderDetailTableViewController.h
//  Post
//
//  Created by cheng on 15/3/3.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsType;
@property (weak, nonatomic) IBOutlet UILabel *goodsVaule;
@property (weak, nonatomic) IBOutlet UILabel *OrderNO;
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (weak, nonatomic) IBOutlet UILabel *vehicleType;
@property (weak, nonatomic) IBOutlet UILabel *goodsWeight;
@property (weak, nonatomic) IBOutlet UILabel *balanceLable;

@property (weak, nonatomic) IBOutlet UILabel *shipperText;

@property (weak, nonatomic) IBOutlet UILabel *shipperPhoneNOText;
@property (weak, nonatomic) IBOutlet UILabel *messrsLable;
@property (weak, nonatomic) IBOutlet UILabel *messrsPhoneNOText;


@property(strong, nonatomic)NSDictionary * selectData;
@end
