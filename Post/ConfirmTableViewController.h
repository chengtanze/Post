//
//  ConfirmTableViewController.h
//  Post
//
//  Created by cheng on 15/2/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface structPhotoInfo : NSObject

@property(nonatomic, assign)BOOL isPhoto;
@property(nonatomic, strong)UIImage * image;

@end

@interface ConfirmTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIView *PhotoGroupView;

@end
