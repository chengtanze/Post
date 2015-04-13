//
//  DeliveryWayView.h
//  Post
//
//  Created by cheng on 15/4/13.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectStlyDelegate <NSObject>

@optional
- (void)pickerDidChaneStly:(NSUInteger)nindex Type:(NSUInteger)type;

@end

@interface DeliveryWayView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>



@property (weak, nonatomic) IBOutlet UIPickerView *goodsPickView;
@property (weak, nonatomic) id<SelectStlyDelegate> delegate;
@property (strong, nonatomic) NSArray * goodsStlyArray;
@property (assign, nonatomic) NSUInteger typeStly;

- (IBAction)okClick:(id)sender;
- (IBAction)cancleClick:(id)sender;

- (void)showInView:(UIView *) view;
- (void)cancelPicker;
@end
