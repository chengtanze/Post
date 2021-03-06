//
//  PersonalDataController.m
//  Post
//
//  Created by wangsl-iMac on 15/3/27.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "PersonalDataController.h"
#import "WWSideslipViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UserDataInterface.h"


@interface PersonalDataController ()

@end

@implementation PersonalDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _userInfo.backgroundColor = [UIColor clearColor];//关键语句
    _changePasswordCell.backgroundColor = [UIColor clearColor];
    _changePhoneCell.backgroundColor = [UIColor clearColor];
    _feedBackCell.backgroundColor = [UIColor clearColor];
    _aboutCell.backgroundColor = [UIColor clearColor];
    
    [self setBackGroupImage:nil];

    self.userHeaderImageView.layer.cornerRadius = self.userHeaderImageView.bounds.size.width / 2.0;
    self.userHeaderImageView.layer.masksToBounds = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [self initLocalData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLocalData{

    self.userNameLB.text = [UserDataInterface sharedClient].userNickName;
    
    NSURL * url = [[NSURL alloc]initWithString:[UserDataInterface sharedClient].userImageHeader];
    [self.userHeaderImageView setImageWithURL:url];
}

-(void)setBackGroupImage:(UIImage *)image{
    UIView *backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"bg.png"]];
    self.tableView.backgroundView = backImageView;
}

//#warning 为了界面美观，所以隐藏了状态栏。如果需要显示则去掉此代码
//- (BOOL)prefersStatusBarHidden
//{
//    return YES; //返回NO表示要显示，返回YES将hiden
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"personData select: section:%ld, row:%ld", indexPath.section, indexPath.row);
    //if (indexPath.section == 0 && indexPath.row == 0) {
        WWSideslipViewController * sides = [WWSideslipViewController sharedInstance:nil andMainView:nil andRightView:nil andBackgroundImage:nil];
        
//        UITabBarController * tabController = (UITabBarController *) sides->mainControl;
//        
//        if (tabController.selectedIndex != 0) {
//            tabController.selectedIndex = 0;
//        }
        
       [sides restoreViewState];
        
        if (_delegate != nil && [self.delegate respondsToSelector:@selector(setIndex:Row:)])
        {
            [_delegate setIndex:indexPath.section Row:indexPath.row];
        }
    //}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepareForSegue");
//    if ([segue.identifier isEqualToString:@"showPersonlData"]) {
//            WWSideslipViewController * sides = [WWSideslipViewController sharedInstance:nil andMainView:nil andRightView:nil andBackgroundImage:nil];
//        
//        [sides restoreViewState];
//    }
    
}

//设置tableview头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}


#pragma mark - Table view data source
//
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
