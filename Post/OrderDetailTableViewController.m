//
//  OrderDetailTableViewController.m
//  Post
//
//  Created by cheng on 15/3/3.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "OrderDetailTableViewController.h"

@interface OrderDetailTableViewController ()

@end

@implementation OrderDetailTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCustomData];

    [self initLocalData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)initCustomData{
    
    self.title = @"订单详情";
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]
                                 initWithTitle:@"跟踪"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(barBtnAction:)];
    
    self.navigationItem.rightBarButtonItem = myButton;
}

-(void)initLocalData{
    if (self.selectData != nil) {
        
        self.goodsName.text = [_selectData valueForKey:@"name"];
        
        NSNumber * numberType = [_selectData valueForKey:@"type"];
        self.goodsType.text = [self getGoodsType:numberType.integerValue];

        self.goodsVaule.text = [_selectData valueForKey:@"value"];
        self.OrderNO.text = [_selectData valueForKey:@"num"];
        
        NSNumber * numberState = [_selectData valueForKey:@"deliveryState"];
        self.orderState.text = [self getGoodsState:numberState.integerValue];;
    
        self.vehicleType.text = [_selectData valueForKey:@""];
        self.goodsWeight.text = [_selectData valueForKey:@"weight"];
        self.balanceLable.text = [_selectData valueForKey:@"free"];
        self.shipperPhoneNOText.text = [_selectData valueForKey:@"pgPhone"];
        self.shipperText.text = [_selectData valueForKey:@"pgName"];
        self.messrsLable.text = [_selectData valueForKey:@"rgName"];
        self.messrsPhoneNOText.text = [_selectData valueForKey:@"rgPhone"];
    }
}

-(void)barBtnAction:(id)sender{
    NSLog(@"barBtnAction");
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * info = [mainStoryboard instantiateViewControllerWithIdentifier:@"OrderTrackViewController"];
    
    [self.navigationController pushViewController:info animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)getGoodsState:(NSInteger)type{
    
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

-(NSString *)getGoodsType:(NSInteger)type{
    
    NSString * strType = @"未知";
    switch (type) {
        case 1:
            strType = @"蛋糕";
            break;
        case 2:
            strType = @"酒水";
            break;
        case 3:
            strType = @"药品";
            break;
        case 4:
            strType = @"食品";
            break;
        case 5:
            strType = @"鲜花";
            break;
        case 6:
            strType = @"数码";
            break;
        case 7:
            strType = @"电器";
            break;
        case 8:
            strType = @"办公";
            break;
        case 9:
            strType = @"服饰";
            break;
        case 10:
            strType = @"护肤";
            break;
        case 11:
            strType = @"图书";
            break;
        case 12:
            strType = @"音像";
            break;
        case 13:
            strType = @"乐器";
            break;
        case 14:
            strType = @"运动";
            break;
        case 15:
            strType = @"其它";
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
