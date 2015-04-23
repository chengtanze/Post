//
//  GoodsInCancleViewController.m
//  Post
//
//  Created by wangsl-iMac on 15/3/2.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "GoodsInCancleViewController.h"
#import "GoodsInComplete_Times_Cell.h"
#import "GoodsInCancle_State_Cell.h"
#import "HttpProtocolAPI.h"
#import "OrderDetailTableViewController.h"
#import "GoodsInComplete_Address_Cell.h"
#import "UIImageView+AFNetworking.h"

@interface GoodsInCancleViewController ()

@end

@implementation GoodsInCancleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndex = -1;
    
    [[HttpProtocolAPI sharedClient] getOrderByState:2 setBlock:^(NSDictionary *data, NSError *error) {
        
        if (data != nil && [self getRetDataState:data]) {
            
            self.arrayCancleData = [data valueForKey:@"data"];
            
            if(![self.arrayCancleData respondsToSelector:@selector(objectAtIndex:)])
            {
                NSLog(@"is null");
                self.arrayCancleData = nil;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    NSLog(@"sections count:%ld", self.arrayCancleData.count);
    return (self.arrayCancleData != nil ? self.arrayCancleData.count : 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 36;
    }
    else if(indexPath.row == 2)
    {
        return 53;
    }
    return 87;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndex = indexPath.section;
    return indexPath;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    NSLog(@"cellForRowAtIndexPath :%ld:%ld", indexPath.section, indexPath.row);
    if (indexPath.row == 0 ) {
        GoodsInComplete_Times_Cell * timeCell = [tableView dequeueReusableCellWithIdentifier:@"Times" forIndexPath:indexPath];
        
        if (self.arrayCancleData != nil) {
            
            NSDictionary * dicData = self.arrayCancleData[indexPath.section];
            if (dicData != nil) {
                timeCell.timeLable.text = [dicData valueForKey:@"num"];
            }
        }
        cell = timeCell;
    }
    else if(indexPath.row == 1){
        GoodsInCancle_State_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"State" forIndexPath:indexPath];

        goodsInfoCell.GoodsState.text = @"已取消";
        
        if (self.arrayCancleData != nil) {
            
            NSDictionary * dicData = self.arrayCancleData[indexPath.section];
            if (dicData != nil) {
                goodsInfoCell.GoodsName.text = [dicData valueForKey:@"name"];
                
                NSNumber * numberState = [dicData valueForKey:@"deliveryState"];
                
                goodsInfoCell.GoodsState.text = [self getGoodsType:numberState.integerValue];
                
                NSDictionary * dicImage = [dicData valueForKey:@"goodsImg"];
                if (dicImage != nil) {
                    if([dicImage respondsToSelector:@selector(objectAtIndex:)]){
                        
                        NSString * strImage =  [dicImage valueForKey:@"imgUrl"][0];
                        
                        NSURL * url = [[NSURL alloc]initWithString:strImage];
                        [goodsInfoCell.GoodsImageView setImageWithURL:url];
                        NSLog(@"%@", strImage);
                    }
                }
            }
        }
        cell = goodsInfoCell;
    }
    else{
        GoodsInComplete_Address_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"Address" forIndexPath:indexPath];
        
//        if (self.arrayCancleData != nil) {
//            NSLog(@"%ld", (long)indexPath.row);
//            NSDictionary * dicData = self.arrayCancleData[indexPath.section];
//            if (dicData != nil) {
//                goodsInfoCell.startAddress.text = [dicData valueForKey:@"pgAddress"];
//                goodsInfoCell.endAddress.text = [dicData valueForKey:@"rgAddress"];
//                
//            }
//        }
        
        cell = goodsInfoCell;
    }

    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[OrderDetailTableViewController class]])
    {
        OrderDetailTableViewController *viewController = (OrderDetailTableViewController *)segue.destinationViewController;
        
        NSLog(@"%ld", (long)_selectIndex);
        
        viewController.selectData = self.arrayCancleData[_selectIndex];
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
