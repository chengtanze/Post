//
//  GoodsTypeView.h
//  Post
//
//  Created by wangsl-iMac on 15/4/3.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsTypeView;
@protocol SelectTypeDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(NSUInteger)nindex;

@end

@interface GoodsTypeView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *goodsPickView;

@property (strong, nonatomic) NSArray * goodsTypeArray;

@property (weak, nonatomic) id<SelectTypeDelegate> delegate;

- (IBAction)okClick:(id)sender;
- (IBAction)cancleClick:(id)sender;

- (void)showInView:(UIView *) view;
- (void)cancelPicker;
@end
