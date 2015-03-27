//
//  EditGoodsController.h
//  Post
//
//  Created by wangsl-iMac on 15/3/26.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditGoodsController : UITableViewController
@property(nonatomic, strong)NSMutableArray * goodsInfo;
@property (weak, nonatomic) IBOutlet UITextField *goodsName;
@property (weak, nonatomic) IBOutlet UITextField *goodsType;
@property (weak, nonatomic) IBOutlet UITextField *goodsVaule;
@property (weak, nonatomic) IBOutlet UITextField *goodsWeight;

@end
