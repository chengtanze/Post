//
//  GoodsInProgressViewController.m
//  Post
//
//  Created by cheng on 15/2/26.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "GoodsInProgressViewController.h"
#import "GoodsInProgress_Order_Cell.h"
#import "GoodsInProgress_GoodsInfo_Cell.h"
#import "HttpProtocolAPI.h"
@interface GoodsInProgressViewController ()

@end

@implementation GoodsInProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[HttpProtocolAPI sharedClient] getOrderByState:nil setBlock:^(NSDictionary *data, NSError *error) {
        
        if (data != nil) {
            
            self.arrayProgressData = [data valueForKey:@"data"];
            
            [self.tableView reloadData];
            
            //NSInteger item = resultArray.count;
            //NSDictionary * item1 = resultArray[0];
            
            
            //NSString * orderID = [result valueForKey:@"orderId"];
        }
        
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.arrayProgressData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 75;
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (indexPath.row == 0 ) {
        GoodsInProgress_Order_Cell * orderCell = [tableView dequeueReusableCellWithIdentifier:@"OrderID" forIndexPath:indexPath];
        
        if (self.arrayProgressData != nil) {
            NSDictionary * dicData = self.arrayProgressData[indexPath.section];
            if (dicData != nil) {
                orderCell.orderIDLable.text = [dicData valueForKey:@"num"];
            }
        }
        
        
        cell = orderCell;
    }
    else{
        GoodsInProgress_GoodsInfo_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"GoodsInfo" forIndexPath:indexPath];
        
        goodsInfoCell.goodsState.text = @"派送中";

        if (self.arrayProgressData != nil) {
            NSDictionary * dicData = self.arrayProgressData[indexPath.section];
            if (dicData != nil) {
                goodsInfoCell.goodsName.text = [dicData valueForKey:@"name"];
                NSNumber * numType = [dicData valueForKey:@"deliveryState"];
                NSInteger type = numType.integerValue;
                
                goodsInfoCell.goodsState.text = [self getGoodsType:type];
                
                if (type == 2) {
                    goodsInfoCell.modifyBtn.hidden = NO;
                }
                else
                    goodsInfoCell.modifyBtn.hidden = YES;
            }
            

        }
        
        cell = goodsInfoCell;
    }

    
    
    
    return cell;
}

-(NSString *)getGoodsType:(NSInteger)type{
    
    NSString * strType = @"未知";
    switch (type) {
        case 0:
            strType = @"待接单";
            break;
        case 1:
            strType = @"已接单";
            break;
        case 2:
            strType = @"待取件";
            break;
        case 3:
            strType = @"取件中";
            break;
        case 4:
            strType = @"已取件";
            break;
        case 5:
            strType = @"派送中";
            break;
        case 6:
            strType = @"已签收";
            break;
        default:
            break;
    }
    
    return strType;
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
