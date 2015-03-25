//
//  CommonAddressController.m
//  Post
//
//  Created by wangsl-iMac on 15/3/23.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "CommonAddressController.h"
#import "CommonAddressTableViewCell.h"
#import "CommonDetailAddressController.h"
#import "AddNewAddressController.h"
@interface CommonAddressController ()

@end

@implementation CommonAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self configLocalData];
}

-(void)configLocalData{
    
    _didSelectIndex = -1;
    
    if(self.userInfo != nil)
    {
        self.userInfo = [[NSMutableArray alloc]initWithCapacity:10];
    }
    NSDictionary * dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"张三丰", @"userName", @"13888888888", @"userPhone", @"深圳市", @"city", @"南山区北环大道", @"address", nil];
    
    NSDictionary * dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"张三", @"userName", @"13888888008", @"userPhone", @"深圳市", @"city", @"南山区北环大道1", @"address", nil];
    
    NSDictionary * dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"李四", @"userName", @"13888888000", @"userPhone", @"深圳市", @"city", @"南山区北环大道2", @"address", nil];
    
    NSDictionary * dic4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"王五", @"userName", @"13008888888", @"userPhone", @"深圳市", @"city", @"南山区北环大道3", @"address", nil];
    
    [self.userInfo addObject:dic1];
    [self.userInfo addObject:dic2];
    [self.userInfo addObject:dic3];
    [self.userInfo addObject:dic4];
    //self.userInfo = [[NSArray alloc]initWithObjects:dic1, dic2, dic3, dic4, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.userInfo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commonAddress" forIndexPath:indexPath];
    
    NSDictionary * dicData = self.userInfo[indexPath.row];
    if (dicData != nil) {
        cell.userNameLable.text = [dicData valueForKey:@"userName"];
        cell.userPhoneNumber.text = [dicData valueForKey:@"userPhone"];
        cell.userAddress.text = [dicData valueForKey:@"address"];
    }
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//   
//}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%ld", indexPath.row);
     _didSelectIndex = indexPath.row;
    return indexPath;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showCommonDetailAddress"]) {
        //NSLog(@"showCommonAddress");
        
        CommonDetailAddressController * viewController = segue.destinationViewController;
        if (_didSelectIndex >= 0 && viewController != nil) {
            viewController.arrInfo = self.userInfo[_didSelectIndex];
        }
        
    }
    else if ([segue.identifier isEqualToString:@"addAddress"])
    {
        AddNewAddressController * viewController = segue.destinationViewController;
        if (viewController != nil) {
            viewController.userInfo = self.userInfo;
        }
    }
}

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
