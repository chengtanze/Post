//
//  ConfirmTableViewController.m
//  Post
//
//  Created by cheng on 15/2/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "ConfirmTableViewController.h"

#import "PhotoGroupTableViewCell.h"
#import "Media_Photo.h"
#import "GoodsPhotoViewController.h"
#import "QCheckBox.h"
#import "PaymentMethodView.h"
#import "HttpProtocolAPI.h"

@implementation structPhotoInfo


@end

@interface ConfirmTableViewController () <getPhotoInfoDelegate, photoGroupDelegate, SelectPayWayDelegate, UITextFieldDelegate>
{
    Media_Photo * mediaPhoto;
    NSInteger selectPhotoIndex;
}
@property(nonatomic, strong)NSMutableArray *imageArray;

@property (weak, nonatomic) IBOutlet PhotoGroupTableViewCell *photoInfoCell;

@end

@implementation ConfirmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLocalData];
    
    [self addConfirmViewAtBottom];
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [button setBackgroundImage:[UIImage imageNamed:@"4-4SMART-BOX-消息_启动预警.png"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//  
//    [self.PhotoGroupView addSubview:button];
    
    //[self.photoInfoCell insertSubview:self.PhotoGroupView atIndex:[[self.photoInfoCell subviews] count]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initLocalData{
    //self.addOrderParams = nil;
    
    selectPhotoIndex = -1;
    
    self.photoInfoCell.delegate = self;
    self.consignerTF.delegate = self;
    self.consignerPhoneTF.delegate = self;
    self.consigneeTF.delegate = self;
    self.consigneePhoneTF.delegate = self;
    
    
    self.imageArray = [[NSMutableArray alloc]initWithCapacity:5];
    for (int index = 0; index < 5; index++) {
        structPhotoInfo * imageInfo = [[structPhotoInfo alloc]init];
        imageInfo.image = nil;
        imageInfo.isPhoto = NO;
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:imageInfo, [NSString stringWithFormat:@"%d", index], nil];
        [self.imageArray addObject:dic];
    }
    
    
    mediaPhoto = [[Media_Photo alloc]init];
    if (mediaPhoto != nil) {
        mediaPhoto.showInViewController = self;
        mediaPhoto.delegate = self;
    }
    
    self.arrayPayWay = [[NSArray alloc]initWithObjects:@"在线支付", @"货到付款", nil];
}


#pragma mark - Media_Photo delegate
-(void)getPhoto:(UIImage *)image{

    NSMutableDictionary * item = self.imageArray[selectPhotoIndex];
    NSString * key = [NSString stringWithFormat:@"%ld", (long)selectPhotoIndex];
    structPhotoInfo * info = [item objectForKey:key];
    info.image = image;
    info.isPhoto = YES;
    
    
//    NSString * key = [NSString stringWithFormat:@"%ld", (long)selectPhotoIndex];
//    structPhotoInfo * info = [[structPhotoInfo alloc]init];
//    info.image = image;
//    info.isPhoto = YES;
//    NSDictionary * item = [[NSDictionary alloc]initWithObjectsAndKeys:info,key, nil];

    
//    [self.imageArray addObject:item];
    
    [_photoInfoCell setPhoto:image byIndex:selectPhotoIndex];

    
}

#pragma mark - PhotoGroupTableViewCell delegate
-(void)selectPhotoIndex:(NSInteger)index{
    selectPhotoIndex = index;
    
    NSDictionary * item = self.imageArray[selectPhotoIndex];
    NSString * key = [NSString stringWithFormat:@"%ld", (long)selectPhotoIndex];
    structPhotoInfo * info = [item objectForKey:key];
    BOOL isPhoto = info.isPhoto;
    if (isPhoto) {
        //判断当前控件背景是默认还是用户拍摄的照片
        
        UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GoodsPhotoViewController * infoView = [mainStoryboard instantiateViewControllerWithIdentifier:@"GoodsPhotoView"];
        
        infoView.photoImage = info.image;
        
        
        [self.navigationController pushViewController:infoView animated:YES];
        
        [infoView updatePhoto];
    }
    else{
        
        
        [mediaPhoto chooseImage];
    }
    
}

- (void)addConfirmViewAtBottom
{
    // 1,创建一个footerView,将它作为tableView的TableFooterView
    UIView *footerView = [[UIView alloc] init];
    // tableView的TableFooterView的宽度固定是320,只有高度可调节
    footerView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 100);
    // 将刚才创建的footerView作为tableView的TableFooterView,目的是防止用户点击底部dockItem时不小心点到了退出按钮,因此要设置一个额外的空间,补充一下TableFooterView的宽度固定是320
    self.tableView.tableFooterView = footerView;
    
    
    QCheckBox *_check2 = [[QCheckBox alloc] initWithDelegate:self];
    _check2.frame = CGRectMake(10, 5, 250, 40);
    [_check2 setTitle:@"同意并接受《全名快递申请协议》" forState:UIControlStateNormal];
    [_check2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_check2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.tableView.tableFooterView addSubview:_check2];
    
    
    
    // 2,创建退出按钮 并添加到tableView的最底部的TableFooterView
    UIButton *btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
    // footerView是作为tableView的TableFooterView存在,按钮是加到了footerView里面,这儿按钮的frame x 10 y 5是相对于footerView的
    btnExit.backgroundColor = [UIColor orangeColor];
    
    btnExit.frame = CGRectMake(20, 45, self.tableView.bounds.size.width - 20 * 2, 30);
    // 按钮上字体大小
    btnExit.titleLabel.font = [UIFont systemFontOfSize:17];
    // 按钮的监听点击事件
    [btnExit addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 分类方法,设置按钮正常和高亮时背景图片(可拉伸)
    //[btnExit setBtnBgImgForNormalAndHighightedWithName:@"common_button_red.png"];
    // 设置按钮上的文字,最后一组,数组只有一行,每一行就是一个字典
    //NSString *btnTitle = [_groups lastObject][0][@"name"];
    [btnExit setTitle:@"确定申请" forState:UIControlStateNormal];
    
    
    
    // 3,最重要的一步,将刚才创建的 退出按钮 添加到tableView的TableFooterView
    //[footerView addSubview:btnExit];
    [self.tableView.tableFooterView addSubview:btnExit];
    
}

// 点击 按钮
- (void)okBtnClick
{
    [self addParams];
    
    NSMutableArray * arrayImage = [[NSMutableArray alloc]initWithCapacity:5];
    for (int nIndex = 0; nIndex < self.imageArray.count; nIndex++) {
        NSMutableDictionary * item = self.imageArray[nIndex];
        if (item != nil) {
            NSString * key = [NSString stringWithFormat:@"%ld", (long)nIndex];
            structPhotoInfo * info = [item objectForKey:key];
            if (info.isPhoto) {
                [arrayImage addObject:info.image];
            }
        }
        
    }
    
    [[HttpProtocolAPI sharedClient] addSenderOrder:self.addOrderParams images:arrayImage setBlock:^(NSDictionary *data, NSError *error) {
        
        if (data != nil) {
            
        }
        
    }];
}

- (IBAction)costTypeClick:(id)sender {
    NSLog(@"ok click");
    if (self.paymentMethodView == nil) {
        self.paymentMethodView = [[PaymentMethodView alloc]init];
        self.paymentMethodView.arrayPayWay = _arrayPayWay;
        self.paymentMethodView.delegate = self;
    }
    
    [self.paymentMethodView showInView:self.view];
    
}

- (void)pickerPayWay:(NSUInteger)index{
    
    NSString *strPay = self.arrayPayWay[index];
    [self.payWayBtn setTitle:strPay forState:UIControlStateNormal];
}

-(void)addParams{
//    
    if (self.addOrderParams != nil) {
        NSString * strConsigner = self.consignerTF.text;
        NSString * strConsignerPhone = self.consignerPhoneTF.text;
        NSString * strConsignee = self.consigneeTF.text;
        NSString * strConsigneePhone = self.consigneePhoneTF.text;
        
        CGFloat free = self.deliveryCost.text.floatValue;
        NSInteger payWay = 0;
        NSNumber * numberfree = [[NSNumber alloc]initWithFloat:free];
        NSNumber * numberPayWay = [[NSNumber alloc]initWithFloat:payWay];
        
        [_addOrderParams setObject: numberPayWay forKey:@"payMethod"];
        [_addOrderParams setObject: numberfree forKey:@"free"];
        [_addOrderParams setObject: strConsigner forKey:@"pgName"];
        [_addOrderParams setObject: strConsignerPhone forKey:@"pgPhone"];
        [_addOrderParams setObject: strConsignee forKey:@"rgName"];
        [_addOrderParams setObject: strConsigneePhone forKey:@"rgPhone"];
//        [_addOrderParams setObject: explanation forKey:@"explanation"];
//        [_addOrderParams setObject: deliveryAID forKey:@"deliveryAID"];
//        [_addOrderParams setObject: receiveAID forKey:@"receiveAID"];
//        [_addOrderParams setObject: deliveryCityID forKey:@"deliveryCityID"];
//        [_addOrderParams setObject: receiveCityID forKey:@"receiveCityID"];
//        [_addOrderParams setObject: iamges forKey:@"iamges"];


    }

}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    if ([self.consignerTF isFirstResponder])
    {
        [self.consignerPhoneTF becomeFirstResponder];
    }
    else if([self.consignerPhoneTF isFirstResponder])
    {
        [self.consigneeTF becomeFirstResponder];
    }
    else if([self.consigneeTF isFirstResponder])
    {
        [self.consigneePhoneTF becomeFirstResponder];
    }
    
    return YES;
}

//-(void)updateViewConstraints{
//    [super updateViewConstraints];
//    _topFirstSep.constant = _topSecondSep.constant = (self.view.frame.size.width - 80 * 2.0) / 2.0;
//}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 5;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 2;
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


- (IBAction)payWayClick:(id)sender {
}
@end
