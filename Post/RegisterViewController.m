//
//  RegisterViewController.m
//  Post
//
//  Created by wangsl-iMac on 15/1/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "RegisterViewController.h"
#import "HttpProtocolAPI.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)getAuthCodeClick:(id)sender {
    [[HttpProtocolAPI sharedClient] getAuthCode:@"13691790130" authType:0 setBlock:^(NSDictionary *data, NSError *error) {
        [self responseAuthCodeNetWorkData:data errorCode:error];
    }];
}

-(BOOL)verifyAuthCode:(NSString *)strAuthCode{
    BOOL verify = NO;
    
    if ([strAuthCode isEqualToString:@""]) {
        NSLog(@"效验码为空");
    }else if(strAuthCode.length != 6){
        NSLog(@"效验码长度错误");
    }
    else{
        verify = YES;
    }
    
    return verify;
}

- (IBAction)completeClick:(id)sender {
    NSString * strUserName;
    NSString * strUserPassWord;
    
#ifdef USERTEST
    strUserName = self.phoneNumber.text;
    strUserPassWord = self.userPassWord.text;
#else
    strUserName = @"13691790130";
    strUserPassWord = @"123456";
#endif
    
    if (![self verifyAuthCode:self.authCode.text]) {
        //提示验证码格式错误
        return;
    }
    
    NSNumber * numberType = [[NSNumber alloc]initWithInt:0];
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: strUserName forKey:@"phoneNum"];
    [params setObject: strUserPassWord forKey:@"password"];
    [params setObject: numberType forKey:@"type"];
    [params setObject: self.authCode.text forKey:@"verifyCode"];
    
    [[HttpProtocolAPI sharedClient] registerUser:params setBlock:^(NSDictionary *data, NSError *error) {
        [self responseRegisterNetWorkData:data errorCode:error];
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

-(void)responseRegisterNetWorkData:(NSDictionary *)data errorCode:(NSError *)error{
    if (data != nil) {
        //解析数据
        NSNumber * state = [data valueForKey:@"state"];
        if (state.intValue == 0) {
            //注册成功
            NSLog(@"注册成功");
        }
        else{
            //注册失败
            NSLog(@"注册失败:%@", state);
        }
        
    }else{
        //网络错误
        NSLog(@"网络错误");
        
    }
}







@end
