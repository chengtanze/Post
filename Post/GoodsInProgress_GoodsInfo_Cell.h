//
//  GoodsInProgress_GoodsInfo_Cell.h
//  Post
//
//  Created by cheng on 15/2/27.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsInProgress_GoodsInfo_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsState;
@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;
- (IBAction)modifyClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@end
