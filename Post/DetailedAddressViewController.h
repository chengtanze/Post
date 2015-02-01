//
//  DetailedAddressViewController.h
//  Post
//
//  Created by cheng on 15/2/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZAreaPickerView.h"

@interface POIDataInfo : NSObject

@property(nonatomic, strong)NSString *poiName;
@property(nonatomic, strong)NSString *address;
@property(nonatomic, strong)NSString *otherInfo;
@property(nonatomic, strong)NSString *image;

@end


@interface DetailedAddressViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cityText;
@property (weak, nonatomic) IBOutlet UITextField *areaText;
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;

@end
