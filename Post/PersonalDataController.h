//
//  PersonalDataController.h
//  Post
//
//  Created by wangsl-iMac on 15/3/27.
//  Copyright (c) 2015年 cheng. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol GetSelectIndexDelegate <NSObject>

-(void)setIndex:(NSUInteger)section Row:(NSUInteger)row;

@end

@interface PersonalDataController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *userInfo;
@property (weak, nonatomic) IBOutlet UITableViewCell *changePasswordCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *changePhoneCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *feedBackCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *aboutCell;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;

@property (weak, nonatomic) id<GetSelectIndexDelegate> delegate;

-(void)initLocalData;
@end
