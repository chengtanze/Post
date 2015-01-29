//
//  IntroduceViewController.m
//  Post
//
//  Created by cheng on 15/1/25.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "IntroduceViewController.h"

@interface IntroduceViewController ()

@end

@implementation IntroduceViewController

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    
    _imageScrollView.hidden = NO;
    
}
-(void)viewDidAppear:(BOOL)animated{
    //[self performSegueWithIdentifier:@"HomeView" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnClick:(UIButton *)sender{
    
    NSLog(@"btnClick");
    
    [self performSegueWithIdentifier:@"HomeVIew" sender:self];
}

-(void)updateViewConstraints{
    [super updateViewConstraints];

    self.scrollViewWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * 3;
    
    self.thirdImageViewWidth.constant = self.secondImageViewWidth.constant = self.firstImageViewWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds);
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
