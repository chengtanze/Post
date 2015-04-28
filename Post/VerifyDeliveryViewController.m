//
//  VerifyDeliveryViewController.m
//  Post
//
//  Created by cheng on 15/4/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "VerifyDeliveryViewController.h"
#import "HttpProtocolAPI.h"
#import "SVProgressHUD.h"

@interface VerifyDeliveryViewController ()<UITextFieldDelegate>

@end

@implementation VerifyDeliveryViewController

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

- (IBAction)sendAuthCodeClick:(id)sender {
    [[HttpProtocolAPI sharedClient] getAuthCode:@"13691790130" authType:4 setBlock:^(NSDictionary *data, NSError *error) {
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

- (BOOL)textFieldShouldReturn:(UITextField*)textField {

    [self.AuthCodeTF resignFirstResponder];
    return YES;
    
}

- (IBAction)verifyDeliveryClick:(id)sender {
    
    _recvPhoneNum = @"13691790130";
    NSString * authCode = self.AuthCodeTF.text;
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    NSNumber * numberOrderID = [[NSNumber alloc]initWithUnsignedInteger:_orderID];
    NSNumber * numberState = [[NSNumber alloc]initWithUnsignedInteger:4];
    [params setObject:authCode forKey:@"verifyCode"];
    [params setObject:numberOrderID forKey:@"orderID"];
    [params setObject:_recvPhoneNum forKey:@"phoneNum"];
    [params setObject:numberState forKey:@"deliveryState"];
    
    [[HttpProtocolAPI sharedClient] updateOrderDeliveryState:params setBlock:^(NSDictionary *data, NSError *error) {
        if (data != nil) {
            NSNumber * numberState = [data valueForKey:@"state"];
            if (numberState.integerValue == 0) {
                [self tipResultByTakeGoods];
                //更改状态
                
                
            }
            else{
                [SVProgressHUD showSuccessWithStatus:@"操作失败"];
            }
            
        }
    }];
    
}

-(void)tipResultByTakeGoods{
    NSString * tip = @"操作成功";
    
    [SVProgressHUD showSuccessWithStatus:tip];
}

@end
