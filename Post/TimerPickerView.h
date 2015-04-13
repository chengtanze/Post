//
//  TimerPickerView.h
//  Post
//
//  Created by cheng on 15/4/13.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectDateTimeDelegate <NSObject>

@optional
- (void)pickerDidDateTime:(NSString *)strDate type:(NSUInteger)index;

@end

@interface TimerPickerView : UIView

@property (weak, nonatomic) IBOutlet UIDatePicker *timerPicker;

- (IBAction)cancle:(id)sender;
- (IBAction)ok:(id)sender;
- (void)showInView:(UIView *) view;
- (void)cancelPicker;

@property (weak, nonatomic) id<SelectDateTimeDelegate> delegate;
@property (assign, nonatomic) NSUInteger index;

@end
