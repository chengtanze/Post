//
//  GoodsOrderViewController.m
//  Post
//
//  Created by cheng on 15/2/26.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "GoodsOrderViewController.h"
#import "SCNavTabBarController.h"

@interface GoodsOrderViewController ()

@end

@implementation GoodsOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * oneViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"GoodsInProgressViewController"];

    oneViewController.title = @"进行中";

    UIViewController * twoViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"GoodsInCompleteViewController"];
    //UIViewController *twoViewController = [[UIViewController alloc] init];
    twoViewController.title = @"已完成";
    
    
    UIViewController *threeViewController = [[UIViewController alloc] init];
    threeViewController.title = @"已取消";
    threeViewController.view.backgroundColor = [UIColor orangeColor];
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneViewController, twoViewController, threeViewController];
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
