//
//  GoodsPhotoViewController.m
//  Post
//
//  Created by cheng on 15/2/13.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "GoodsPhotoViewController.h"

@interface GoodsPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@end

@implementation GoodsPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updatePhoto];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updatePhoto{
    self.goodsImageView.image = self.photoImage;
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
