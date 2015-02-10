//
//  OrderTrack_UserItem_Cell.h
//  Post
//
//  Created by cheng on 15/2/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectClickDelegate <NSObject>

-(void)SelectType:(NSUInteger)type;

@end


@interface OrderTrack_UserItem_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
- (IBAction)userCurPos:(id)sender;
- (IBAction)callPhone:(id)sender;

@property(nonatomic, weak)id<SelectClickDelegate> delegate;
@property(nonatomic, strong)NSString *strUserName;
@property(nonatomic, strong)NSString *strUserPhone;
@property(nonatomic, strong)UIImage * userHeaderImage;

-(void)upDateUserInfo;
@end
