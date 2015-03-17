//
//  SelectRangeView.m
//  Post
//
//  Created by wangsl-iMac on 15/3/17.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "SelectRangeView.h"

@implementation SelectRangeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    self = [[[NSBundle mainBundle] loadNibNamed:@"SelectRange" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.rangePickView.delegate = self;
        self.arrayDistance = [[NSArray alloc]initWithObjects:@"500",@"800",@"1000",@"2000", nil];
        self.arrayMeasurement = [[NSArray alloc]initWithObjects:@"米", @"千米", nil];
    }
    return self;
}

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height - 45, self.frame.size.width, self.frame.size.height);
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

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.arrayDistance count];
            break;
        case 1:
            return [self.arrayMeasurement count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

        switch (component) {
            case 0:
                return self.arrayDistance[row];
                break;
            case 1:
                return self.arrayMeasurement[row];
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
            _distance = self.arrayDistance[row];
            break;
        case 1:
            _measurement = self.arrayMeasurement[row];
            break;
            
        default:
            break;
    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }
}

- (IBAction)cancle:(id)sender {
    [self cancelPicker];
}

- (IBAction)OK:(id)sender {
    [self cancelPicker];
}
@end
