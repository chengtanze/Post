//
//  PaymentMethodView.h
//  Post
//
//  Created by cheng on 15/4/15.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectPayWayDelegate <NSObject>

@optional
- (void)pickerPayWay:(NSUInteger)index;

@end

@interface PaymentMethodView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

- (void)showInView:(UIView *) view;
- (void)cancelPicker;
@property(strong, nonatomic) NSArray * arrayPayWay;
@property(weak, nonatomic) id<SelectPayWayDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *payWayPV;

- (IBAction)cancleClick:(id)sender;
- (IBAction)okClick:(id)sender;


@end
