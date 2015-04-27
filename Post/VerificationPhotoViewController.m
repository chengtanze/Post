//
//  VerificationPhotoViewController.m
//  Post
//
//  Created by cheng on 15/4/27.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "VerificationPhotoViewController.h"
#import "Media_Photo.h"
#import "PhotoGroupView.h"
#import "HttpProtocolAPI.h"
#import "SVProgressHUD.h"

@interface VerificationPhotoViewController ()<PhotoGroupViewDelegate, getPhotoInfoDelegate>

@property(strong, nonatomic) Media_Photo * mediaPhoto;
@property(assign, nonatomic) NSInteger selectPhotoIndex;
@property(nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation VerificationPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initLocalData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLocalData{
    self.photoGroupView.delegate = self;
    
    self.imageArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    self.mediaPhoto = [[Media_Photo alloc]init];
    if (_mediaPhoto != nil) {
        _mediaPhoto.showInViewController = self;
        _mediaPhoto.delegate = self;
    }
}

-(void)selectPhotoIndex:(NSInteger)index{
    _selectPhotoIndex = index;
    
    [_mediaPhoto chooseImage];
}

#pragma mark - Media_Photo delegate
-(void)getPhoto:(UIImage *)image{
    
    self.imageArray[_selectPhotoIndex] = image;
   
    [_photoGroupView setPhoto:image byIndex:_selectPhotoIndex];

}

- (IBAction)upLoadPhotoClick:(id)sender {
    
    [[HttpProtocolAPI sharedClient] addValidateImg:self.imageArray orderID:self.orderID setBlock:^(NSDictionary *data, NSError *error) {
       
        if (data != nil) {
            NSNumber * numberState = [data valueForKey:@"state"];
            if (numberState.integerValue == 0) {
                
                [SVProgressHUD showSuccessWithStatus:@"操作成功"];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [SVProgressHUD showSuccessWithStatus:@"操作失败"];
            }
        }
        
    }];
    
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
