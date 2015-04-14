//
//  MapSearchViewController.h
//  Post
//
//  Created by cheng on 15/1/30.
//  Copyright (c) 2015年 cheng. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol SelectAdressDelegate <NSObject>

@optional
- (void)pickerAdress:(NSString *)adress;

@end

@interface MapSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) id<SelectAdressDelegate> delegate;
@end
