//
//  OftenGoodsTableViewCell.h
//  Post
//
//  Created by wangsl-iMac on 15/3/26.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OftenGoodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLable;
@property (weak, nonatomic) IBOutlet UILabel *goodsType;
@property (weak, nonatomic) IBOutlet UILabel *goodsVaule;
@property (weak, nonatomic) IBOutlet UILabel *goodsWeight;
@property (weak, nonatomic) IBOutlet UILabel *vehicle;

@end
