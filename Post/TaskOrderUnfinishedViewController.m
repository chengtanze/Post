//
//  TaskOrderUnfinishedViewController.m
//  Post
//
//  Created by cheng on 15/3/8.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "TaskOrderUnfinishedViewController.h"

#import "TaskOrderUnfinished_Address_Cell.h"
#import "TaskOrderUnfinished_Goods_Cell.h"
#import "TaskOrderUnfinished_Order_Cell.h"
#import "TaskOrderUnfinished_Times_Cell.h"
#import "HttpProtocolAPI.h"
#import "UIImageView+AFNetworking.h"
#import "TaskOrderUnfinished_OK_Cell.h"
#import "SVProgressHUD.h"
#import "PhotoGroupTableViewCell.h"
#import "VerificationPhotoViewController.h"
#import "VerifyDeliveryViewController.h"
#import "MJRefresh.h"



@interface TaskOrderUnfinishedViewController ()<SelectUnfinishedIndexDelegate>
{

}
@property (assign, nonatomic) BOOL bReLoad;

@end

@implementation TaskOrderUnfinishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bReLoad = NO;
    _selectIndex = -1;
    
    // 2.集成刷新控件
    [self setupRefresh];
    
    [self sendTaskOrderProtocol];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    if (_bReLoad) {
        [self sendTaskOrderProtocol];
        _bReLoad = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        //[self.tableView reloadData];
        [self sendTaskOrderProtocol];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        
    });
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

-(void)reLoadData{
    //self.tableView
    _bReLoad = YES;
    
}

-(void)sendTaskOrderProtocol{
    [[HttpProtocolAPI sharedClient] getTaskOrderByState:0 setBlock:^(NSDictionary *data, NSError *error) {
        [self.tableView headerEndRefreshing];
        if (data != nil && [self getRetDataState:data]) {
            
            self.arrayOrderUnfinishedData = [data valueForKey:@"data"];
            
            if(![self.arrayOrderUnfinishedData respondsToSelector:@selector(objectAtIndex:)])
            {
                NSLog(@"is null");
                self.arrayOrderUnfinishedData = nil;
            }
            
            
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source
//设置tableview头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return -100;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    //NSLog(@"sections count:%ld", self.arrayCancleData.count);
    
    return (self.arrayOrderUnfinishedData != nil ? self.arrayOrderUnfinishedData.count : 0);
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 6;
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
        return 70;
    }else if (indexPath.row == 4)
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
        TaskOrderUnfinished_Order_Cell * timeCell = [tableView dequeueReusableCellWithIdentifier:@"OrderID" forIndexPath:indexPath];
        
        if (self.arrayOrderUnfinishedData != nil) {
            
            NSDictionary * dicData = self.arrayOrderUnfinishedData[indexPath.section];
            if (dicData != nil) {
                timeCell.orderID.text = [dicData valueForKey:@"num"];

            }
        }
        cell = timeCell;
    }
    else if(indexPath.row == 1){
        TaskOrderUnfinished_Goods_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"State" forIndexPath:indexPath];
        
        goodsInfoCell.goodsStateLB.text = @"已取消";
        
        if (self.arrayOrderUnfinishedData != nil) {
            
            NSDictionary * dicData = self.arrayOrderUnfinishedData[indexPath.section];
            if (dicData != nil) {
                goodsInfoCell.goodsNameLB.text = [dicData valueForKey:@"name"];
                
                NSNumber * numberState = [dicData valueForKey:@"deliveryState"];
                
                goodsInfoCell.goodsStateLB.text = [self getGoodsType:numberState.integerValue];
                
                NSDictionary * dicImage = [dicData valueForKey:@"goodsImg"];
                if (dicImage != nil) {
                    if([dicImage respondsToSelector:@selector(objectAtIndex:)]){
                        
                        NSString * strImage =  [dicImage valueForKey:@"imgUrl"][0];
                        
                        NSURL * url = [[NSURL alloc]initWithString:strImage];
                        [goodsInfoCell.goodsImageView setImageWithURL:url];
                        NSLog(@"%@", strImage);
                    }
                }
            }
        }
        cell = goodsInfoCell;
    }
    else if(indexPath.row == 2){
        TaskOrderUnfinished_Address_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"Address" forIndexPath:indexPath];
        
        if (self.arrayOrderUnfinishedData != nil) {
            NSLog(@"%ld", (long)indexPath.row);
            NSDictionary * dicData = self.arrayOrderUnfinishedData[indexPath.section];
            if (dicData != nil) {
                goodsInfoCell.startAddressLB.text = [dicData valueForKey:@"pgAddress"];
                goodsInfoCell.endAddressLB.text = [dicData valueForKey:@"rgAddress"];
                
            }
        }
        
        cell = goodsInfoCell;
    }
    else if(indexPath.row == 3){
        TaskOrderUnfinished_Times_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"Times" forIndexPath:indexPath];
        
        if (self.arrayOrderUnfinishedData != nil) {
            NSLog(@"%ld", (long)indexPath.row);
            NSDictionary * dicData = self.arrayOrderUnfinishedData[indexPath.section];
            if (dicData != nil) {
                goodsInfoCell.recTimesLB.text = [dicData valueForKey:@"rgEndTime"];
                goodsInfoCell.remainTimeLB.text = @"0天";//[dicData valueForKey:@"rgAddress"];
                
            }
        }
        
        cell = goodsInfoCell;
    }
    else if(indexPath.row == 4){
        PhotoGroupTableViewCell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"Images" forIndexPath:indexPath];
        [goodsInfoCell clearPhotoGroups];
        
        [goodsInfoCell setPhoto:[UIImage imageNamed:@"ic_add_pic_normal.png"] byIndex:0];
        
        if (self.arrayOrderUnfinishedData != nil) {
            
            NSDictionary * dicData = self.arrayOrderUnfinishedData[indexPath.section];
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
        
        cell = goodsInfoCell;

    }
    else if(indexPath.row == 5){
        TaskOrderUnfinished_OK_Cell *goodsInfoCell = [tableView dequeueReusableCellWithIdentifier:@"Button" forIndexPath:indexPath];
        
        goodsInfoCell.tag = indexPath.section;
        goodsInfoCell.delegate = self;
        
        if (self.arrayOrderUnfinishedData != nil) {
            
            NSLog(@"%ld", (long)indexPath.row);
            NSDictionary * dicData = self.arrayOrderUnfinishedData[indexPath.section];
            if (dicData != nil) {
                NSNumber * numberState = [dicData valueForKey:@"deliveryState"];
                goodsInfoCell.nState = numberState.integerValue;
                [goodsInfoCell.funtcionBtn setTitle:[self getButtonTitle:numberState.integerValue] forState:UIControlStateNormal];
            }
        }

        
        cell = goodsInfoCell;
    }
    
    
    return cell;
}

-(void)SelectIndex:(NSUInteger)index{
    
    NSLog(@"SelectIndex :%ld", (unsigned long)index);
    
    NSDictionary * dicData = self.arrayOrderUnfinishedData[index];
    if (dicData != nil) {
        NSNumber * numberState = [dicData valueForKey:@"deliveryState"];
        NSUInteger nState = numberState.integerValue;
        NSNumber * numberOrderID = [dicData valueForKey:@"id"];
        
        [self dealWithUserState:nState orderID:numberOrderID.integerValue];
    }
}

-(void)dealWithUserState:(NSUInteger)state orderID:(NSUInteger)orderID{
    
    switch (state) {
        case 1:
        {
            [self dealTakeGoodsState:orderID];
        }
            break;
        case 2:
        {
            [self dealVerifyPhotos:orderID];
        }
            break;
        case 3:
        {
            [self dealVerifyDelivery:orderID phoneNum:@"13691790130"];
        }
            break;
        default:
            break;
    }
    
}

-(void)dealTakeGoodsState:(NSUInteger)orderID{
    
    [[HttpProtocolAPI sharedClient] updateOrderDeliveryState:2 orderID:orderID setBlock:^(NSDictionary *data, NSError *error) {
        if (data != nil) {
            NSNumber * numberState = [data valueForKey:@"state"];
            if (numberState.integerValue == 0) {
                [self tipResultByTakeGoods];
                //更改状态
                
                [self sendTaskOrderProtocol];
            }
            else{
                [SVProgressHUD showSuccessWithStatus:@"操作失败"];
            }
            
        }
    }];
    
}

-(void)dealVerifyPhotos:(NSUInteger)orderID{
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VerificationPhotoViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"VerificationPhotoViewController"];
    info.orderID = orderID;
    
    [self.navigationController pushViewController:info animated:YES];
    
}

-(void)dealVerifyDelivery:(NSUInteger)orderID phoneNum:(NSString *)phoneNum{
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VerifyDeliveryViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"VerifyDeliveryViewController"];
    info.orderID = orderID;
    info.recvPhoneNum = phoneNum;
    
    [self.navigationController pushViewController:info animated:YES];
    
}

-(void)tipResultByTakeGoods{
    NSString * tip = @"该订单已进入取货状态，请在30分钟内完成取货";

    [SVProgressHUD showSuccessWithStatus:tip];
}

-(NSString *)getButtonTitle:(NSUInteger)nIndex{
    //0未接单、1已接单、2取货中、3派送中、4已签收（完成），5已取消，默认为0
    NSString * strType = @"未知";
    switch (nIndex) {
        case 0:
            strType = @"未接单";
            break;
        case 1:
            strType = @"现在去取货";
            break;
        case 2:
            strType = @"拍验视照";
            break;
        case 3:
            strType = @"确认送达";
            break;
        case 4:
            strType = @"待定";
            break;
        case 5:
            strType = @"待定";
            break;
        case 6:
            strType = @"待定";
            break;
        default:
            break;
    }
    
    return strType;
}

-(NSString *)getGoodsType:(NSInteger)type{
    //0未接单、1已接单、2取货中、3派送中、4已签收（完成），5已签收，默认为0
    NSString * strType = @"未知";
    switch (type) {
        case 0:
            strType = @"待接单";
            break;
        case 1:
            strType = @"已接单";
            break;
        case 2:
            strType = @"取货中";
            break;
        case 3:
            strType = @"派送中";
            break;
        case 4:
            strType = @"已签收";
            break;
        case 5:
            strType = @"已签收";
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
