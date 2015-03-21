//
//  ApplyCourierController.m
//  Post
//
//  Created by cheng on 15/3/21.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "ApplyCourierController.h"
#import "QCheckBox.h"

@interface ApplyCourierController ()<QCheckBoxDelegate>

@property(nonatomic, assign)BOOL checked;

@end

@implementation ApplyCourierController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _checked = NO;
    [self addConfirmViewAtBottom];
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

- (void)addConfirmViewAtBottom
{
    // 1,创建一个footerView,将它作为tableView的TableFooterView
    UIView *footerView = [[UIView alloc] init];
    // tableView的TableFooterView的宽度固定是320,只有高度可调节
    footerView.frame = CGRectMake(0, 0, self.ApplyTableView.bounds.size.width, 100);
    // 将刚才创建的footerView作为tableView的TableFooterView,目的是防止用户点击底部dockItem时不小心点到了退出按钮,因此要设置一个额外的空间,补充一下TableFooterView的宽度固定是320
    self.ApplyTableView.tableFooterView = footerView;
    
    
    QCheckBox *_check2 = [[QCheckBox alloc] initWithDelegate:self];
    _check2.frame = CGRectMake(10, 5, 250, 40);
    [_check2 setTitle:@"同意并接受《全名快递申请协议》" forState:UIControlStateNormal];
    [_check2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_check2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.ApplyTableView.tableFooterView addSubview:_check2];
    


    // 2,创建退出按钮 并添加到tableView的最底部的TableFooterView
    UIButton *btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
    // footerView是作为tableView的TableFooterView存在,按钮是加到了footerView里面,这儿按钮的frame x 10 y 5是相对于footerView的
    btnExit.backgroundColor = [UIColor orangeColor];
    
    btnExit.frame = CGRectMake(10, 45, 300, 30);
    // 按钮上字体大小
    btnExit.titleLabel.font = [UIFont systemFontOfSize:17];
    // 按钮的监听点击事件
    [btnExit addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 分类方法,设置按钮正常和高亮时背景图片(可拉伸)
    //[btnExit setBtnBgImgForNormalAndHighightedWithName:@"common_button_red.png"];
    // 设置按钮上的文字,最后一组,数组只有一行,每一行就是一个字典
    //NSString *btnTitle = [_groups lastObject][0][@"name"];
    [btnExit setTitle:@"确定申请" forState:UIControlStateNormal];
    
    
    
    // 3,最重要的一步,将刚才创建的 退出按钮 添加到tableView的TableFooterView
    //[footerView addSubview:btnExit];
    [self.ApplyTableView.tableFooterView addSubview:btnExit];
    
}

// 点击 按钮
- (void)exitBtnClick
{
    if (self.checked) {
        
    }
    else{
        
    }
}

#pragma arguments QCheckBoxDelegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked{
    self.checked = checked;
}

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
