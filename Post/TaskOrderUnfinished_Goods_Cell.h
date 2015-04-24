//
//  TaskOrderUnfinished_Goods_Cell.h
//  Post
//
//  Created by cheng on 15/4/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskOrderUnfinished_Goods_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLB;
@property (weak, nonatomic) IBOutlet UILabel *goodsStateLB;
@property (weak, nonatomic) IBOutlet UILabel *valuesLB;
- (IBAction)callClick:(id)sender;

@end
