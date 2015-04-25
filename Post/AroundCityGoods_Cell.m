//
//  AroundCityGoods_Cell.m
//  Post
//
//  Created by cheng on 15/4/20.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "AroundCityGoods_Cell.h"

@implementation AroundCityGoods_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)getOrderClick:(id)sender {

    NSInteger select = self.tag;
    //NSLog(@"getOrderClick select :%ld", self.tag);
    if (_delegate != nil && [self.delegate respondsToSelector:@selector(SelectIndex:)]) {
        [_delegate SelectIndex:select];
    }
}
@end
