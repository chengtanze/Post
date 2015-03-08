//
//  TaskOrderViewController.m
//  Post
//
//  Created by cheng on 15/3/8.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "TaskOrderViewController.h"
#import "SCNavTabBarController.h"

@interface TaskOrderViewController ()

@end

@implementation TaskOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * oneViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"TaskOrderUnfinishedViewController"];
    
    oneViewController.title = @"   未完成   ";
    
    UIViewController * twoViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"GoodsInCompleteViewController"];
    twoViewController.title = @"   已完成   ";
    
    
    UIViewController *threeViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"GoodsInCancleViewController"];
    threeViewController.title = @"   已取消   ";
    
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
