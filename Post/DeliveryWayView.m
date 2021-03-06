//
//  DeliveryWayView.m
//  Post
//
//  Created by cheng on 15/4/13.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "DeliveryWayView.h"

@implementation DeliveryWayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"DeliveryWay" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.goodsPickView.delegate = self;
        //self.goodsTypeArray = goods;
    }
    return self;
}

- (IBAction)okClick:(id)sender {
    [self cancelPicker];
}

- (IBAction)cancleClick:(id)sender {
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
            if (self.goodsStlyArray != nil)
                return [self.goodsStlyArray count];
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
            if (self.goodsStlyArray != nil) {
                NSString * dicData = self.goodsStlyArray[row];
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
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStly:Type:)]) {
        [self.delegate pickerDidChaneStly:row Type:_typeStly];
    }
}


@end
