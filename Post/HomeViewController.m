//
//  HomeViewController.m
//  Post
//
//  Created by wangsl-iMac on 15/1/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "HomeViewController.h"
#import "Custom_ScrollImageView.h"
#import "QRCodesViewController.h"
#import "WWSideslipViewController.h"
#import "PersonalDataController.h"
#import "LoginViewController.h"
#import "HttpProtocolAPI.h"
#import "EditCargoInfoTableViewController.h"
#import "UserDataInterface.h"

@interface HomeViewController ()<CustromScrollImageViewTapDelegate, UITabBarControllerDelegate>

@property(nonatomic, strong)Custom_ScrollImageView * srcollImage;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.11 green:0.690 blue:0.988 alpha:1];
    
    self.tabBarController.delegate = self;
    
    [self login];
    
    //1EB0FC
//    [[HttpProtocolAPI sharedClient] login:^(NSDictionary *data, NSError *error) {
//        if (data != nil) {
//            
//        }else{
//            
//        }
//        
//        
//    }];
    

    
    
    
//    WWSideslipViewController * sides = [WWSideslipViewController sharedInstance:nil andMainView:nil andRightView:nil andBackgroundImage:nil];
//    
//    PersonalDataController * dataCtrl = (PersonalDataController *)sides->righControl;
//    dataCtrl.delegate = self;

    
    //[sides addPanGsetureToHomeView];
}

-(void)login{
    
    NSArray * userInfo = [[UserDataInterface sharedClient] loadLoginInfo];
    
    if (userInfo != nil && ![userInfo isKindOfClass:[NSNull class]] && userInfo.count > 0) {
        NSString * userName = userInfo[0];
        NSString * userPW = userInfo[1];
        
        if (![userName isEqualToString:@""] && ![userPW isEqualToString:@""]) {
            
            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            
            [info login:userName passWord:userPW loginType:1];
            
        }
        else{
            
        }
    }

}

-(void)viewDidLayoutSubviews{
    
    NSString *str1 = @"1.JPG";
    NSString *str2 = @"2.JPG";
    NSString *str3 = @"3.JPG";
    NSString *str4 = @"4.JPG";
    
    NSArray * array = @[str1, str2, str3, str4];
    
    static BOOL bFirst = NO;
    if (!bFirst) {
        bFirst = YES;
        
        self.srcollImage = [[Custom_ScrollImageView alloc]initWithFrame:self.cellForScrollView.frame  picArray:array];
        self.srcollImage.delegate = self;
        [self.cellForScrollView addSubview:self.srcollImage];
        [_srcollImage upDataScrollViewPoint];
    }

    //NSLog(@"viewDidLayoutSubviews");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置tableview头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(void)ScrollImageViewdidSelectRowAtIndexPath:(NSInteger)index{
    NSLog(@"ScrollImageViewdidSelectRowAtIndexPath :%ld", (long)index);
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self getLoginState]) {
        if (indexPath.section == 1 || indexPath.section == 2) {
            
            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            
            [self.navigationController pushViewController:info animated:YES];

            return nil;
        }
    }
    return indexPath;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 2 && indexPath.row == 0)
    {
        NSLog(@"二维码");
        QRCodesViewController * rt = [[QRCodesViewController alloc]init];
        [self presentViewController:rt animated:YES completion:^{
            
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[EditCargoInfoTableViewController class]])
    {
//            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"NewPassWordViewController"];
//        
//            [self.navigationController pushViewController:info animated:YES];
    }
}

-(BOOL)getLoginState{
    return [UserDataInterface sharedClient].bLogin;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if (![self getLoginState]) {
        UIViewController * currentView = [self getCurrentVC];
        //if (![currentView.title isEqual:@"登陆"]){
        //if (![currentView isKindOfClass:[LoginViewController class]]) {
            UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            
            [self.navigationController pushViewController:info animated:YES];
            
            return NO;
       // }

    }

    return YES;
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
