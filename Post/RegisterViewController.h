//
//  RegisterViewController.h
//  Post
//
//  Created by wangsl-iMac on 15/1/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *verifyPassWord;
@property (weak, nonatomic) IBOutlet UITextField *authCode;
- (IBAction)getAuthCodeClick:(id)sender;
- (IBAction)completeClick:(id)sender;

@end
