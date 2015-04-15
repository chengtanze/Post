//
//  PaymentMethodView.m
//  Post
//
//  Created by cheng on 15/4/15.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "PaymentMethodView.h"

@implementation PaymentMethodView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"PaymentMethod" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.payWayPV.delegate = self;
        
        //self.timerPicker.delegate = self;
        //self.goodsTypeArray = goods;
    }
    return self;
}

- (IBAction)cancleClick:(id)sender {
    [self cancelPicker];
}

- (IBAction)okClick:(id)sender {
    [self cancelPicker];
}

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            if (self.arrayPayWay != nil)
                return [self.arrayPayWay count];
            break;
        }
        default:
            return 0;
            break;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
        {
            if (self.arrayPayWay != nil) {
                NSString * dicData = self.arrayPayWay[row];
                return dicData;
            }
            
            return @"";
        }
            break;
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            //_distance = self.goodsTypeArray[row];
            break;
            
        default:
            break;
    }
    
    if([self.delegate respondsToSelector:@selector(pickerPayWay:)]) {
        [self.delegate pickerPayWay:row];
    }
}


@end
