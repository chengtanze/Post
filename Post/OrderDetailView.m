//
//  OrderDetailView.m
//  Post
//
//  Created by cheng on 15/3/15.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetail" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    
    return self;
}

- (void)showInView:(UIView *) view
{
    self.alpha = 0.8;
    self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height - 45, view.frame.size.width, self.frame.size.height);
    }];
}

- (void)removeInView
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

@end
