//
//  GoodsInCompleteViewController.m
//  Post
//
//  Created by cheng on 15/2/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "GoodsInCompleteViewController.h"

#import "GoodsInComplete_Address_Cell.h"
#import "GoodsInComplete_State_Cell.h"
#import "GoodsInComplete_Times_Cell.h"

#import "SVProgressHUD.h"
#import "GMDCircleLoader.h"

#import "HttpProtocolAPI.h"
#import "OrderDetailTableViewController.h"

@interface GoodsInCompleteViewController ()

@end

@implementation GoodsInCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[SVProgressHUD show];
    //[GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    
    _selectIndex = -1;
    
    [[HttpProtocolAPI sharedClient] getOrderByState:0 setBlock:^(NSDictionary *data, NSError *error) {
        
        if (data != nil && [self getRetDataState:data]) {
            
            self.arrayCompleteData = [data valueForKey:@"data"];
            
            [self.tableView reloadData];
        }
        
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(BOOL)getRetDataState:(NSDictionary *)data{
    BOOL ret = NO;
    if (data != nil) {
        NSNumber * numberState = [data valueForKey:@"state"];
        NSInteger state = numberState.integerValue;
        if (state == 0) {
            ret = YES;
        }
    }

    return ret;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }
    
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return self.arrayCompleteData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 3;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.section;
    return indexPath;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[OrderDetailTableViewController class]])
    {
        OrderDetailTableViewController *viewController = (OrderDetailTableViewController *)segue.destinationViewController;
        
        NSLog(@"%ld", (long)_selectIndex);
        
        viewController.selectData = self.arrayCompleteData[_selectIndex];
        //        viewController.delegate = self;
        //        NSInteger nType = 0;
        //        if ([segue.identifier isEqualToString:@"sourceAddress"])
        //        {
        //            nType = 0;
        //        }
        //        else if ([segue.identifier isEqualToString:@"targetAddress"]){
        //            nType = 1;
        //        }
        //        
        //        viewController.addressType = nType;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0 ) {
        GoodsInComplete_Times_Cell * timeCell = [tableView dequeueReusableCellWithIdentifier:@"Times" forIndexPath:indexPath];
        timeCell.timeLable.text = @"2015-02-28 15:30:08";
        
        cell = timeCell;
    }
    else if(indexPath.row == 1){
        GoodsInComplete_State_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"State" forIndexPath:indexPath];
        //goodsInfoCell.goodsNameLable.text = @"玩具";
        //goodsInfoCell.goodsState.text = @"派送中";
        
        if (self.arrayCompleteData != nil) {
            NSLog(@"%ld", (long)indexPath.row);
            NSDictionary * dicData = self.arrayCompleteData[indexPath.section];
            if (dicData != nil) {
                goodsInfoCell.goodsNameLable.text = [dicData valueForKey:@"name"];
                
                NSNumber * numberState = [dicData valueForKey:@"deliveryState"];
                
                goodsInfoCell.goodsState.text = [self getGoodsType:numberState.integerValue];
            }
        }
        
        
        cell = goodsInfoCell;
    }
    else{
        GoodsInComplete_Address_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"Address" forIndexPath:indexPath];
//        goodsInfoCell.startAddress.text = @"深圳市宝安区西乡";
//        goodsInfoCell.endAddress.text = @"深圳市南山区科技园";
        
        if (self.arrayCompleteData != nil) {
            NSLog(@"%ld", (long)indexPath.row);
            NSDictionary * dicData = self.arrayCompleteData[indexPath.section];
            if (dicData != nil) {
                goodsInfoCell.startAddress.text = [dicData valueForKey:@"pgAddress"];
                goodsInfoCell.endAddress.text = [dicData valueForKey:@"rgAddress"];

            }
        }
        
        cell = goodsInfoCell;
    }
    
    return cell;
}


-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear");
    [GMDCircleLoader hideFromView:self.view animated:YES];
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
