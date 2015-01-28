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
     
////    _imageScrollView.contentSize=CGSizeMake(self.view.frame.size.width * 2.0, 0);
//    _imageScrollView.showsVerticalScrollIndicator = NO;
//    _imageScrollView.showsHorizontalScrollIndicator = NO;
//    _imageScrollView.clipsToBounds = YES;
//    _imageScrollView.scrollEnabled = YES;
    _imageScrollView.pagingEnabled = YES;
//    _imageScrollView.delegate = self;
//    //baseScrollView.backgroundColor=[UIColor orangeColor];
    
    
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
//    [btn setTitle:@"立即体验" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//
//    [_thirdImageView addSubview:btn];
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
