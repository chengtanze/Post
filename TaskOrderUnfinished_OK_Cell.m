//
//  TaskOrderUnfinished_OK_Cell.m
//  Post
//
//  Created by cheng on 15/4/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "TaskOrderUnfinished_OK_Cell.h"

@implementation TaskOrderUnfinished_OK_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnClick:(id)sender {
    
    if (_delegate != nil && [self.delegate respondsToSelector:@selector(SelectIndex:)]) {
        [self.delegate SelectIndex:self.tag];
    }

}
@end
