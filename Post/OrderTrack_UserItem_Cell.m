//
//  OrderTrack_UserItem_Cell.m
//  Post
//
//  Created by cheng on 15/2/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderTrack_UserItem_Cell.h"

@implementation OrderTrack_UserItem_Cell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)upDateUserInfo{
    self.userName.text = self.strUserName;
    self.userPhone.text = self.strUserPhone;
    self.userHeaderImageView.image = self.userHeaderImage;

}

- (IBAction)userCurPos:(id)sender {
    NSLog(@"pos");
    if (_delegate != nil && [self.delegate respondsToSelector:@selector(SelectType:)]) {
        [self.delegate SelectType:0];
    }
}

- (IBAction)callPhone:(id)sender {
    if (_delegate != nil && [self.delegate respondsToSelector:@selector(SelectType:)]) {
        [self.delegate SelectType:1];
    }
}
@end
