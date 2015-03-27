//
//  EditGoodsController.m
//  Post
//
//  Created by wangsl-iMac on 15/3/26.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "EditGoodsController.h"

@interface EditGoodsController ()

@end

@implementation EditGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addConfirmViewAtBottom];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.goodsInfo != nil) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addConfirmViewAtBottom
{
    // 1,创建一个footerView,将它作为tableView的TableFooterView
    UIView *footerView = [[UIView alloc] init];
    // tableView的TableFooterView的宽度固定是320,只有高度可调节
    footerView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 100);
    // 将刚才创建的footerView作为tableView的TableFooterView,目的是防止用户点击底部dockItem时不小心点到了退出按钮,因此要设置一个额外的空间,补充一下TableFooterView的宽度固定是320
    self.tableView.tableFooterView = footerView;
    
    
    
    
    
    // 2,创建退出按钮 并添加到tableView的最底部的TableFooterView
    UIButton *btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
    // footerView是作为tableView的TableFooterView存在,按钮是加到了footerView里面,这儿按钮的frame x 10 y 5是相对于footerView的
    btnExit.backgroundColor = [UIColor orangeColor];
    
    btnExit.frame = CGRectMake(20, 25, self.tableView.bounds.size.width - 20 * 2, 30);
    // 按钮上字体大小
    btnExit.titleLabel.font = [UIFont systemFontOfSize:17];
    // 按钮的监听点击事件
    [btnExit addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 分类方法,设置按钮正常和高亮时背景图片(可拉伸)
    //[btnExit setBtnBgImgForNormalAndHighightedWithName:@"common_button_red.png"];
    // 设置按钮上的文字,最后一组,数组只有一行,每一行就是一个字典
    //NSString *btnTitle = [_groups lastObject][0][@"name"];
    [btnExit setTitle:@"确定" forState:UIControlStateNormal];
    
    
    
    // 3,最重要的一步,将刚才创建的 退出按钮 添加到tableView的TableFooterView
    //[footerView addSubview:btnExit];
    [self.tableView.tableFooterView addSubview:btnExit];
    
}

// 点击 按钮
- (void)exitBtnClick
{
    [self upDateUserInfo];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)upDateUserInfo{
    NSString *goodsName = _goodsName.text;
    NSString *goodsType = _goodsType.text;
    NSString *goodsVaule = _goodsVaule.text;
    NSString *goodsWeight = _goodsWeight.text;
    
    NSMutableDictionary * dicNewData = [[NSMutableDictionary alloc]initWithObjectsAndKeys:goodsName, @"goodsName" , goodsType, @"goodsType" ,goodsVaule, @"goodsVaule" , goodsWeight, @"goodsWeight" ,nil];
    
    if (self.goodsInfo != nil) {
        [self.goodsInfo addObject:dicNewData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textfieldshouldreturn");
    [_goodsName resignFirstResponder];
    [_goodsType resignFirstResponder];
    [_goodsVaule resignFirstResponder];
    [_goodsWeight resignFirstResponder];
    return YES;
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
