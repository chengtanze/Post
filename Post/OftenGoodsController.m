//
//  OftenGoodsController.m
//  Post
//
//  Created by cheng on 15/3/25.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OftenGoodsController.h"
#import "OftenGoodsTableViewCell.h"
#import "EditGoodsController.h"
#import "GoodsDetailController.h"

@interface OftenGoodsController ()

@end

@implementation OftenGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self configLocalData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    NSLog(@"viewWillAppear");
}

-(void)configLocalData{
    
    if(self.userInfo == nil)
    {
        self.userInfo = [[NSMutableArray alloc]initWithCapacity:10];
    }
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"鲜花", @"goodsName", @"鲜花", @"goodsType", @"200元", @"goodsVaule", @"1公斤", @"goodsWeight", @"公交", @"vehicle", nil];
    
    NSMutableDictionary * dic2 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"电器", @"goodsName", @"冰箱", @"goodsType", @"1200元", @"goodsVaule", @"1公斤", @"goodsWeight", @"公交", @"vehicle", nil];
    
    NSMutableDictionary * dic3 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"电器", @"goodsName", @"空调", @"goodsType", @"2200元", @"goodsVaule", @"1公斤", @"goodsWeight", @"公交", @"vehicle", nil];
    
    NSMutableDictionary * dic4 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"数码产品", @"goodsName", @"相机", @"goodsType", @"200元", @"goodsVaule", @"1公斤", @"goodsWeight", @"公交", @"vehicle", nil];
    
    [self.userInfo addObject:dic1];
    [self.userInfo addObject:dic2];
    [self.userInfo addObject:dic3];
    [self.userInfo addObject:dic4];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _userInfo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OftenGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"oftenGoods" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell != nil) {
        NSDictionary * dicData = _userInfo[indexPath.row];
        if (dicData != nil) {
            cell.goodsNameLable.text = [dicData valueForKey:@"goodsName"];
            cell.goodsType.text = [dicData valueForKey:@"goodsType"];
            cell.goodsVaule.text = [dicData valueForKey:@"goodsVaule"];
            cell.goodsWeight.text = [dicData valueForKey:@"goodsWeight"];
            cell.vehicle.text = [dicData valueForKey:@"vehicle"];
        }
        
    }
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%ld", indexPath.row);
    _didSelectIndex = indexPath.row;
    return indexPath;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"showAddGoods"]) {
        //NSLog(@"showCommonAddress");
        
        EditGoodsController * viewController = segue.destinationViewController;
        if (_didSelectIndex >= 0 && viewController != nil) {
            viewController.goodsInfo = self.userInfo;
        }
        
    }
    else if ([segue.identifier isEqualToString:@"showGoodsDetail"])
    {
        GoodsDetailController * viewController = segue.destinationViewController;
        if (viewController != nil) {

            viewController.detailInfo = self.userInfo[_didSelectIndex];
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
