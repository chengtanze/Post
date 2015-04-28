//
//  VerificationPhotoViewController.h
//  Post
//
//  Created by cheng on 15/4/27.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskOrderUnfinishedViewController.h"
@class PhotoGroupView;

@interface VerificationPhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet PhotoGroupView *photoGroupView;

@property (assign, nonatomic) NSUInteger orderID;

- (IBAction)upLoadPhotoClick:(id)sender;

@property(weak, nonatomic)id<TaskOrderUnfinishedDelegate> delegate;
@end
