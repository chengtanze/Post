//
//  LoginViewController.m
//  Post
//
//  Created by cheng on 15/2/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "LoginViewController.h"
#import "HttpProtocolAPI.h"

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

- (IBAction)loginClick:(id)sender {
    NSString * strUserName;
    NSString * strUserPassWord;
    
#ifdef USERTEST
    strUserName = self.phoneNumber.text;
    strUserPassWord = self.userPassWord.text;
#else
    strUserName = @"18576430783";
    strUserPassWord = @"123456";
#endif
    
    
    NSString * imei = @"12345678";
    NSString * ip = @"192.168.0.26";
    
    NSMutableDictionary * params= [[NSMutableDictionary alloc]init];
    [params setObject: strUserName forKey:@"phoneNum"];
    [params setObject: strUserPassWord forKey:@"password"];
    [params setObject: imei forKey:@"imei"];
    [params setObject: ip forKey:@"ip"];
    
    [[HttpProtocolAPI sharedClient] login:params setBlock:^(NSDictionary *data, NSError *error) {
        
        //登陆请求返回处理
        [self responseNetWorkData:data errorCode:error];
    }];
}

-(void)responseNetWorkData:(NSDictionary *)data errorCode:(NSError *)error{
    if (data != nil) {
        //解析数据
        NSNumber * state = [data valueForKey:@"state"];
        if (state.intValue == 0) {
            //登陆成功
            NSDictionary * dataArray = [data valueForKey:@"data"];
            
            if (dataArray != nil) {
                NSString *id = [dataArray valueForKey:@"id"];
                NSString *nickName = [dataArray valueForKey:@"nickName"];
                NSString *phoneNum = [dataArray valueForKey:@"phoneNum"];
                NSString *honestRank = [dataArray valueForKey:@"honestRank"];   //诚信指数
                NSString *avator = [dataArray valueForKey:@"avatar"];           //头像链接
                NSString *rank = [dataArray valueForKey:@"rank"];               //用户等级，0普通用户，1快递人，默认为0
                NSString *sid = [dataArray valueForKey:@"sid"];                 //sessionId
                
                
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
