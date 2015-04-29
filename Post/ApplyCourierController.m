//
//  ApplyCourierController.m
//  Post
//
//  Created by cheng on 15/3/21.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "ApplyCourierController.h"
#import "QCheckBox.h"
#import "Media_Photo.h"
#import "HttpProtocolAPI.h"
#import "SVProgressHUD.h"

@interface ApplyCourierController ()<getPhotoInfoDelegate, QCheckBoxDelegate, UITextFieldDelegate>

@property(nonatomic, assign)BOOL checked;
@property(nonatomic, strong)Media_Photo * mediaPhoto;
@property(nonatomic, assign)NSUInteger imageIndex;
@end

@implementation ApplyCourierController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self addConfirmViewAtBottom];
    [self configLocalData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    //[self.imagesArray removeAllObjects];
}

#pragma mark - Table view data source



-(void)configLocalData{
    self.userNameLabel.delegate = self;
    self.IDCardLabel.delegate = self;
    self.contactPersonLabel.delegate = self;
    self.phoneCallLabel.delegate = self;
    
    self.userHeaderImageView.layer.cornerRadius = 32.0;
    self.userHeaderImageView.layer.masksToBounds = YES;
    
    _mediaPhoto = [[Media_Photo alloc]init];
    if (_mediaPhoto != nil) {
        _mediaPhoto.showInViewController = self;
        _mediaPhoto.delegate = self;
    }
    
    self.imagesArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    _checked = NO;
    _imageIndex = 0;
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    NSLog(@"index:%ld", (long)recognizer.view.tag);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textfieldshouldreturn");
    [self.userNameLabel resignFirstResponder];
    [self.IDCardLabel resignFirstResponder];
    [self.contactPersonLabel resignFirstResponder];
    [self.phoneCallLabel resignFirstResponder];
    return YES;
}

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
    
    btnExit.frame = CGRectMake(20, 45, self.tableView.bounds.size.width - 20 * 2, 30);
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
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc]initWithCapacity:10];
    NSUInteger areaID = 77;
    NSNumber * numberAreaID = [[NSNumber alloc]initWithUnsignedInteger:areaID];
    
    [params setObject:numberAreaID forKey:@"areaID"];
    [params setObject:self.userNameLabel.text forKey:@"realName"];
    [params setObject:self.IDCardLabel.text forKey:@"IDCode"];
    [params setObject:self.contactPersonLabel.text forKey:@"contact"];
    [params setObject:self.phoneCallLabel.text forKey:@"contPhone"];
    
//    [params setObject:@"程程" forKey:@"realName"];
//    [params setObject:@"12345678" forKey:@"IDCode"];
//    [params setObject:@"程程" forKey:@"contact"];
//    [params setObject:@"123456" forKey:@"contPhone"];
    
    [[HttpProtocolAPI sharedClient] getPersonal:params images:self.imagesArray setBlock:^(NSDictionary *data, NSError *error) {
        
        if (data != nil) {
            NSNumber * numberState = [data valueForKey:@"state"];
            
            [self tipResult:numberState.integerValue];
//            if (numberState.integerValue == 0) {
//                
//            }
//            else{
//                
//            }
        }
        
    }];
}

-(void)tipResult:(NSInteger)state{
    
    NSString * strMsg = @"";
    if (state == 0) {
        strMsg = @"操作成功";
    }else if (state == 1){
        strMsg = @"图片移动错误";
    }
    else if (state == 2){
        strMsg = @"保存图片错误";
    }
    else if (state == 3){
        strMsg = @"图片格式不正确";
    }
    else if (state == 4){
        strMsg = @"图片大小超过2M";
    }else if (state == 5){
        strMsg = @"申请失败";
    }
    else if (state == 6){
        strMsg = @"已申请";
    }else if (state == 7){
        strMsg = @"已存在该身份证号";
    }
    
    [SVProgressHUD showSuccessWithStatus:strMsg duration:2];
}

#pragma arguments QCheckBoxDelegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked{
    self.checked = checked;
}

- (IBAction)obverseImage:(id)sender {
    _imageIndex = 1;
    [_mediaPhoto chooseImage];
}

- (IBAction)reverseImage:(id)sender {
     _imageIndex = 2;
    [_mediaPhoto chooseImage];
}

- (IBAction)takeIDCardClick:(id)sender {
    _imageIndex = 3;
    [_mediaPhoto chooseImage];
}

- (IBAction)drivingLicenseClick:(id)sender {
    _imageIndex = 4;
    [_mediaPhoto chooseImage];
}

#pragma mark - Media_Photo delegate
-(void)getPhoto:(UIImage *)image{
    if (_imageIndex == 0){
        self.userHeaderImageView.image = image;
    }
    else if (_imageIndex == 1) {
        
        [self.obverseButton setImage:image forState:UIControlStateNormal];
    }else if (_imageIndex == 2){
        
        [self.reverserButton setImage:image forState:UIControlStateNormal];
    }
    else if (_imageIndex == 3){
        
        [self.takeIDCardButton setImage:image forState:UIControlStateNormal];
    }else if (_imageIndex == 4)
    {
        [self.drivingLicenseBtn setImage:image forState:UIControlStateNormal];
    }
    else{
        return;
    }
 
    [self.imagesArray addObject:image];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        _imageIndex = 0;
        [_mediaPhoto chooseImage];
    }
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
