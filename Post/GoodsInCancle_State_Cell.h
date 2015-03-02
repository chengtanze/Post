//
//  GoodsInCancle_State_Cell.h
//  Post
//
//  Created by wangsl-iMac on 15/3/2.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsInCancle_State_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *GoodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *GoodsName;
@property (weak, nonatomic) IBOutlet UILabel *GoodsState;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;
@property (weak, nonatomic) IBOutlet UIButton *delButton;

@end
