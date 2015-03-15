//
//  OrderDetailView.h
//  Post
//
//  Created by cheng on 15/3/15.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailView : UIView
- (void)showInView:(UIView *) view;
-(id)init;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsEndLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toStartDistance;
@property (weak, nonatomic) IBOutlet UILabel *toEndDistance;

@end
