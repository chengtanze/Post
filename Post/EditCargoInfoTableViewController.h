//
//  EditCargoInfoTableViewController.h
//  Post
//
//  Created by cheng on 15/1/31.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedAddressViewController.h"
@class GoodsTypeView;
@class DeliveryWayView;
@interface EditCargoInfoTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIButton *firstAddress;
@property (weak, nonatomic) IBOutlet UIButton *secondAddress;
@property (weak, nonatomic) IBOutlet UITextField *goodsNameTF;
@property (weak, nonatomic) IBOutlet UIButton *goodsTypeBtn;
@property (weak, nonatomic) IBOutlet UITextField *goodsVaulesTF;
@property (weak, nonatomic) IBOutlet UITextField *goodsWeight;

- (IBAction)changeAddress:(id)sender;
- (IBAction)goodsTypeBtn:(id)sender;
- (IBAction)pgWayBtn:(id)sender;



@property (strong, nonatomic) NSArray * goodsTypeArray;
@property (strong, nonatomic) NSArray * deliveryWayArray;

@property (strong, nonatomic) GoodsTypeView * goodsTypeView;
@property (strong, nonatomic) DeliveryWayView * deliveryWayView;

@property (strong, nonatomic) NSMutableArray * addOrderParams;


@end
