//
//  NewPassWordViewController.h
//  Post
//
//  Created by cheng on 15/4/22.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPassWordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyPassWordTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
- (IBAction)verificationCodeClick:(id)sender;
- (IBAction)okClick:(id)sender;

@end
