//
//  IntroduceViewController.h
//  Post
//
//  Created by cheng on 15/1/25.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroduceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdImageViewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@end
