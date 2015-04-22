//
//  NewPassWordViewController.m
//  Post
//
//  Created by cheng on 15/4/22.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "NewPassWordViewController.h"
#import "HttpProtocolAPI.h"
#import "UserDataInterface.h"
#import "SVProgressHUD.h"

@interface NewPassWordViewController ()

@end

@implementation NewPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"设置密码";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)verificationCodeClick:(id)sender {
    [[HttpProtocolAPI sharedClient] getAuthCode:[UserDataInterface sharedClient].userPhoneNum authType:2 setBlock:^(NSDictionary *data, NSError *error) {
        [self responseAuthCodeNetWorkData:data errorCode:error];
    }];
}

-(void)responseAuthCodeNetWorkData:(NSDictionary *)data errorCode:(NSError *)error{
    if (data != nil) {
        //解析数据
        NSNumber * state = [data valueForKey:@"state"];
        if (state.intValue == 0) {
            //获取验证码成功
            NSLog(@"获取验证码成功");
        }
        else{
            //获取验证码失败
            NSLog(@"获取验证码失败");
        }
        
    }else{
        //网络错误
        NSLog(@"网络错误");
        
    }
}

- (IBAction)okClick:(id)sender {
    NSMutableDictionary * params = [[NSMutableDictionary alloc]initWithCapacity:15];
    
    NSString *strPassWord = self.passWordTF.text;
    NSString * strAuthCode = self.verificationCodeTF.text;
    NSNumber * numberType = [[NSNumber alloc]initWithInt:2];
    NSString * userPhoneNumer = [UserDataInterface sharedClient].userPhoneNum;
    
    [params setObject: strPassWord forKey:@"password"];
    [params setObject: strAuthCode forKey:@"verifyCode"];
    [params setObject: numberType forKey:@"type"];
    [params setObject: userPhoneNumer forKey:@"phoneNum"];
    
    [[HttpProtocolAPI sharedClient] updatePassword:params setBlock:^(NSDictionary *data, NSError *error) {
        if (data != nil) {
            //解析数据
            NSNumber * state = [data valueForKey:@"state"];
            if (state.intValue == 0) {
                //登陆成功
                NSDictionary * dataArray = [data valueForKey:@"data"];
                
                if (dataArray != nil) {

                    }
                    
                [SVProgressHUD showSuccessWithStatus:@"操作成功"];

            }
            else{
                //登陆失败
                [SVProgressHUD showSuccessWithStatus:@"操作失败"];
            }
            
        }else{
            //网络错误
            [SVProgressHUD showSuccessWithStatus:@"操作失败"];
        }

    }];
    
}
@end
