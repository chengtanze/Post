//
//  LoginViewController.h
//  Post
//
//  Created by cheng on 15/2/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)loginClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *userPassWord;

@property(strong, nonatomic)NSString * userName;
@property(strong, nonatomic)NSString * userPW;

-(void)login:(NSString *)strUserName passWord:(NSString *)strUserPassWord loginType:(NSInteger)type;
@end
