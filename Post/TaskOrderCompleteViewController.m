//
//  TaskOrderCompleteViewController.m
//  Post
//
//  Created by cheng on 15/4/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "TaskOrderCompleteViewController.h"
#import "HttpProtocolAPI.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "TaskOrderComplete_Address_Cell.h"
#import "TaskOrderComplete_Order_Cell.h"
#import "TaskOrderComplete_State_Cell.h"
#import "PhotoGroupTableViewCell.h"

@interface TaskOrderCompleteViewController ()

@end

@implementation TaskOrderCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndex = -1;
    
    [[HttpProtocolAPI sharedClient] getTaskOrderByState:1 setBlock:^(NSDictionary *data, NSError *error) {
        
        if (data != nil && [self getRetDataState:data]) {
            
            self.arrayOrderCompleteData = [data valueForKey:@"data"];
            
            if(![self.arrayOrderCompleteData respondsToSelector:@selector(objectAtIndex:)])
            {
                NSLog(@"is null");
                self.arrayOrderCompleteData = nil;
            }
            
            [self.tableView reloadData];
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

//设置tableview头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    //NSLog(@"sections count:%ld", self.arrayCancleData.count);
    return (self.arrayOrderCompleteData != nil ? self.arrayOrderCompleteData.count : 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 36;
    }
    else if(indexPath.row == 1)
    {
        return 87;
    }
    else if(indexPath.row == 2)
    {
        return 53;
    }
    else if(indexPath.row == 3)
    {
        return 80;
    }
    
    return 44;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.section;
    return indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    NSLog(@"cellForRowAtIndexPath :%ld:%ld", (long)indexPath.section, (long)indexPath.row);
    if (indexPath.row == 0 ) {
        TaskOrderComplete_Order_Cell * timeCell = [tableView dequeueReusableCellWithIdentifier:@"OrderID" forIndexPath:indexPath];
        
        if (self.arrayOrderCompleteData != nil) {
            
            NSDictionary * dicData = self.arrayOrderCompleteData[indexPath.section];
            if (dicData != nil) {
                timeCell.orderIDLB.text = [dicData valueForKey:@"num"];
            }
        }
        cell = timeCell;
    }
    else if(indexPath.row == 1){
        TaskOrderComplete_State_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"State" forIndexPath:indexPath];
        
        goodsInfoCell.goodsStateLB.text = @"已取消";
        
        if (self.arrayOrderCompleteData != nil) {
            
            NSDictionary * dicData = self.arrayOrderCompleteData[indexPath.section];
            if (dicData != nil) {
                goodsInfoCell.goodsNameLB.text = [dicData valueForKey:@"name"];
                
                NSNumber * numberState = [dicData valueForKey:@"deliveryState"];
                
                goodsInfoCell.goodsStateLB.text = [self getGoodsType:numberState.integerValue];
                
                NSDictionary * dicImage = [dicData valueForKey:@"goodsImg"];
                if (dicImage != nil) {
                    if([dicImage respondsToSelector:@selector(objectAtIndex:)]){
                        
                        NSString * strImage =  [dicImage valueForKey:@"imgUrl"][0];
                        
                        NSURL * url = [[NSURL alloc]initWithString:strImage];
                        [goodsInfoCell.goodsImgeView setImageWithURL:url];
                        NSLog(@"%@", strImage);
                    }
                }
            }
        }
        cell = goodsInfoCell;
    }
    else if(indexPath.row == 2){
        TaskOrderComplete_Address_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"Address" forIndexPath:indexPath];
        
        if (self.arrayOrderCompleteData != nil) {
            NSLog(@"%ld", (long)indexPath.row);
            NSDictionary * dicData = self.arrayOrderCompleteData[indexPath.section];
            if (dicData != nil) {
                goodsInfoCell.startAddressLB.text = [dicData valueForKey:@"pgAddress"];
                goodsInfoCell.endAddressLB.text = [dicData valueForKey:@"rgAddress"];
            }
        }
        
        cell = goodsInfoCell;
    }
    else if(indexPath.row == 3){
        PhotoGroupTableViewCell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"Photos" forIndexPath:indexPath];

        if (self.arrayOrderCompleteData != nil) {
            
            NSDictionary * dicData = self.arrayOrderCompleteData[indexPath.section];
            if (dicData != nil) {
                
                NSDictionary * dicImage = [dicData valueForKey:@"validateImg"];
                if (dicImage != nil) {
                    if([dicImage respondsToSelector:@selector(objectAtIndex:)]){
                        
                        for (int nIndex = 0; nIndex < dicImage.count; nIndex++) {
                            NSString * strImage =  [dicImage valueForKey:@"imgUrl"][nIndex];
                            
                            NSURL * url = [[NSURL alloc]initWithString:strImage];
                            
                            [goodsInfoCell setURLPhoto:url byIndex:nIndex];
                            NSLog(@"%@", strImage);
                        }

                    }
                }
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
