//
//  AroundCityGoods_Cell.h
//  Post
//
//  Created by cheng on 15/4/20.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectIndexDelegate <NSObject>

-(void)SelectIndex:(NSUInteger)index;

@end

@interface AroundCityGoods_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLB;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *distanceMeLB;
@property (weak, nonatomic) IBOutlet UILabel *distanceGoodsLB;
@property (weak, nonatomic) IBOutlet UILabel *startTimesLB;
@property (weak, nonatomic) IBOutlet UILabel *endTimesLB;
@property (weak, nonatomic) IBOutlet UILabel *startAddressLB;
@property (weak, nonatomic) IBOutlet UILabel *endAddressLB;
@property (weak, nonatomic) IBOutlet UILabel *goodsValue;
@property (weak, nonatomic) IBOutlet UILabel *ImportantExplanationLB;
- (IBAction)getOrderClick:(id)sender;

@property (weak, nonatomic) id<SelectIndexDelegate> delegate;

@end
