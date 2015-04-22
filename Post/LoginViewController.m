//
//  LoginViewController.m
//  Post
//
//  Created by cheng on 15/2/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "LoginViewController.h"
#import "HttpProtocolAPI.h"
#import "PublicFunction.h"
#import "UserDataInterface.h"
#import "SVProgressHUD.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

//#define USERTEST

- (IBAction)loginClick:(id)sender {

    
#ifdef USERTEST
    _strUserName = self.phoneNumber.text;
    _strUserPassWord = self.userPassWord.text;
#else
    _strUserName = @"13691790130";//@"18576430783";//
    _strUserPassWord = @"12345678";
#endif
    
    [self login:_strUserName passWord:_strUserPassWord loginType:0];
}

-(void)login:(NSString *)strUserName passWord:(NSString *)strUserPassWord loginType:(NSInteger)type{
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: strUserName forKey:@"phoneNum"];
    
    NSString * md5_PassWord = [PublicFunction md5:strUserPassWord];
    [params setObject: md5_PassWord forKey:@"password"];
    
    [[HttpProtocolAPI sharedClient] login:params setBlock:^(NSDictionary *data, NSError *error) {
        
        //登陆请求返回处理
        [self responseNetWorkData:data errorCode:error loginType:type];
    }];
}

-(void)responseNetWorkData:(NSDictionary *)data errorCode:(NSError *)error loginType:(NSInteger)type{
    if (data != nil) {
        //解析数据
        NSNumber * state = [data valueForKey:@"state"];
        if (state.intValue == 0) {
            //登陆成功
            NSDictionary * dataArray = [data valueForKey:@"data"];
            
            if (dataArray != nil) {
//                NSString *id = [dataArray valueForKey:@"id"];
//                NSString *nickName = [dataArray valueForKey:@"nickName"];
//                NSString *phoneNum = [dataArray valueForKey:@"phoneNum"];
//                NSString *honestRank = [dataArray valueForKey:@"honestRank"];   //诚信指数
//                NSString *avator = [dataArray valueForKey:@"avatar"];           //头像链接
//                NSString *rank = [dataArray valueForKey:@"rank"];               //用户等级，0普通用户，1快递人，默认为0
//                NSString *sid = [dataArray valueForKey:@"sid"];                 //sessionId
//                NSString *key = [dataArray valueForKey:@"key"];
                
                [UserDataInterface sharedClient].bLogin = YES;
                [UserDataInterface sharedClient].dicUserInfo = dataArray;
                if (type == 0) {
                    [[UserDataInterface sharedClient] saveLoginInfo:self.strUserName passWord:self.strUserPassWord];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
                [SVProgressHUD showSuccessWithStatus:@"登陆成功"];

            }
        }
        else{
            //登陆失败
            
        }
        
    }else{
        //网络错误
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //NSLog(@"%@", segue.identifier);
    if ([segue.identifier isEqualToString:@"showRegister"]) {
        
    }
}






@end
