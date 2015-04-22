//
//  ChangePassWordViewController.m
//  Post
//
//  Created by cheng on 15/4/22.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "ChangePassWordViewController.h"

@interface ChangePassWordViewController ()

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"修改密码";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextClick:(id)sender {
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"NewPassWordViewController"];
    
    [self.navigationController pushViewController:info animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
