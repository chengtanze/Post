//
//  AccountInfoViewController.m
//  Post
//
//  Created by cheng on 15/3/21.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "SCNavTabBarController.h"
#import "AccountInComeController.h"
#import "AccountExpendController.h"

@interface AccountInfoViewController ()

@end

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * oneViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"AccountInComeController"];
    
    oneViewController.title = @"   收入   ";
    
    UIViewController * twoViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"AccountExpendController"];
    twoViewController.title = @"   支出   ";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneViewController, twoViewController];
    navTabBarController.showArrowButton = NO;
    [navTabBarController addParentController:self];
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

@end
