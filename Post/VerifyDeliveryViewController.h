//
//  VerifyDeliveryViewController.h
//  Post
//
//  Created by cheng on 15/4/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyDeliveryViewController : UIViewController

@property (assign, nonatomic) NSUInteger orderID;
@property (strong, nonatomic) NSString * recvPhoneNum;

@property (weak, nonatomic) IBOutlet UITextField *AuthCodeTF;
- (IBAction)sendAuthCodeClick:(id)sender;
- (IBAction)verifyDeliveryClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;

@end
