//
//  MeTableViewController.m
//  Post
//
//  Created by cheng on 15/4/20.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "MeTableViewController.h"
#import "HttpProtocolAPI.h"
#import "UserDataInterface.h"
#import "UIImageView+AFNetworking.h"
#import "WWSideslipViewController.h"
#import "PersonalDataController.h"
#import "SVProgressHUD.h"

@interface MeTableViewController ()<GetSelectIndexDelegate>

@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self judgeCourierIdentity];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)initLocalData{
    self.navigationController.title = @"我的";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.11 green:0.690 blue:0.988 alpha:1];
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [self.backGroupView addGestureRecognizer:singleRecognizer];
    
    self.userHeaderImageView.layer.masksToBounds = YES;
    self.userHeaderImageView.layer.cornerRadius = self.userHeaderImageView.bounds.size.width / 2.0;
    
    self.userNameLB.text = [UserDataInterface sharedClient].userNickName;
    
    NSURL * url = [[NSURL alloc]initWithString:[UserDataInterface sharedClient].userImageHeader];
    [self.userHeaderImageView setImageWithURL:url];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    //NSLog(@"index:%ld", (long)recognizer.view.tag);
    
    [self showEditPersonDataView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self initLocalData];
    
    WWSideslipViewController * sides = [WWSideslipViewController sharedInstance:nil andMainView:nil andRightView:nil andBackgroundImage:nil];
    
    PersonalDataController * dataCtrl = (PersonalDataController *)sides->righControl;
    dataCtrl.delegate = self;
    
    [dataCtrl initLocalData];
    
    [sides addPanGsetureToHomeView];
}

-(void)viewWillDisappear:(BOOL)animated{
    WWSideslipViewController * sides = [WWSideslipViewController sharedInstance:nil andMainView:nil andRightView:nil andBackgroundImage:nil];
    
    [sides removeGestureToHomeView];
}

-(void)showEditPersonDataView{
    
    //先显示首页
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"EditPersonController"];
    
    [self.navigationController pushViewController:info animated:YES];
    //    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //    [self presentViewController:info animated:YES completion:^{
    //
    //    }];
}

-(void)showChangePassWordView{
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"ChangePassWordViewController"];
    
    [self.navigationController pushViewController:info animated:YES];
}

-(void)setIndex:(NSUInteger)section Row:(NSUInteger)row{
    
    if (section == 0) {
        //显示个人信息
        [self showEditPersonDataView];
    }
    else if (section == 1){
        if (row == 0) {
            //修改密码
            [self showChangePassWordView];
        }
        else{
            
        }
       
    }
    else if (section == 2){
        //更换手机号码
    }
    else if (section == 3){
        //反馈
    }
    else if (section == 4){
        //帮助
    }
}

-(void)judgeCourierIdentity{
    //bCourierIdentity
    [[HttpProtocolAPI sharedClient] getApplyState:^(NSDictionary *data, NSError *error) {
        if (data != nil) {
            NSNumber * numberState = [data valueForKey:@"state"];
            
            if (numberState.integerValue == 1) {
                _bCourierIdentity = YES;
            }
            else{
                _bCourierIdentity = NO;
            }
        }
    }];
}


#pragma mark - Table view data source

//设置tableview头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        //判断是否为有快递人身份
        if(_bCourierIdentity)
        {
            [SVProgressHUD showSuccessWithStatus:@"您已是全民乐递承运人，无需重复申请" duration:2];
            return nil;
        }
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

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
