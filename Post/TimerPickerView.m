//
//  TimerPickerView.m
//  Post
//
//  Created by cheng on 15/4/13.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "TimerPickerView.h"

@implementation TimerPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"TimerPicker" owner:self options:nil] objectAtIndex:0];
    if (self) {
        //self.timerPicker.delegate = self;
        //self.goodsTypeArray = goods;
    }
    return self;
}

- (IBAction)cancle:(id)sender {
    [self cancelPicker];
}

- (IBAction)ok:(id)sender {
    NSDate *selected = [_timerPicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    
    NSString *message = [[NSString alloc] initWithFormat:
                         @"The date and time you selected is: %@", destDateString];
    
    NSLog(@"start time :%@", message);
    if([self.delegate respondsToSelector:@selector(pickerDidDateTime:type:)]) {
        [self.delegate pickerDidDateTime:destDateString type:_index];
    }
    
    
    [self cancelPicker];
}

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height - 100, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
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
