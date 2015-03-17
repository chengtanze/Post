//
//  SelectRangeView.h
//  Post
//
//  Created by wangsl-iMac on 15/3/17.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectRangeView;
@protocol SelectRangeDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(SelectRangeView *)picker;

@end

@interface SelectRangeView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *rangePickView;
@property (weak, nonatomic) id <SelectRangeDelegate> delegate;
@property(nonatomic, strong)NSArray * arrayDistance;
@property(nonatomic, strong)NSArray * arrayMeasurement;

@property(nonatomic, strong)NSString *distance;
@property(nonatomic, strong)NSString *measurement;

- (IBAction)cancle:(id)sender;
- (IBAction)OK:(id)sender;

- (void)showInView:(UIView *) view;
- (void)cancelPicker;
@end

