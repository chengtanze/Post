//
//  EditCargoInfoTableViewController.m
//  Post
//
//  Created by cheng on 15/1/31.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "EditCargoInfoTableViewController.h"
#import "ConfirmTableViewController.h"
#import "GoodsTypeView.h"
#import "HttpProtocolAPI.h"
#import "DeliveryWayView.h"
#import "TimerPickerView.h"

@interface EditCargoInfoTableViewController ()<UITextFieldDelegate, GetAddressTypeDelegate, SelectTypeDelegate, SelectStlyDelegate, SelectDateTimeDelegate>


@end

@implementation EditCargoInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLocalData];
    
    [self initNetWorkData];
    
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
    self.nPgWay = 0;
    self.nRgWay = 0;
    self.nGoodsType = 0;
    
    self.addOrderParams = [[NSMutableDictionary alloc]initWithCapacity:15];
    
    self.deliveryWayArray = [[NSArray alloc]initWithObjects:@"协商", @"上门取件", @"到指定点取件", @"到代收点取件", nil];
    
    self.consigneeWayArray = [[NSArray alloc]initWithObjects:@"协商", @"送件上门", @"到指定点取件", @"到代收点取件", nil];
    
    self.goodsNameTF.delegate = self;
    self.goodsVaulesTF.delegate = self;
    self.goodsWeight.delegate = self;
}

-(void)initNetWorkData{
    [[HttpProtocolAPI sharedClient]getGoodsTypeList:^(NSDictionary *data, NSError *error) {
        if (data != nil && [self getRetDataState:data]) {
            
            self.goodsTypeArray = [data valueForKey:@"data"];
            
            for (int nIndex = 0; nIndex < self.goodsTypeArray.count; nIndex++) {
                NSDictionary * dicData = self.goodsTypeArray[nIndex];
                if (dicData != nil) {
                    NSLog(@"%@:%@",[dicData valueForKey:@"id"], [dicData valueForKey:@"type"]) ;
                }
            }
            
        }else{
            
        }
    }];
    
    //    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"1", @"id", @"数码", @"type",@"0", @"isActive",nil];
    //    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2", @"id", @"电器", @"type",@"0", @"isActive",nil];
    //    NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3", @"id", @"生活用品", @"type",@"1", @"isActive",nil];
    //    NSDictionary *dic4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"1", @"id", @"数码", @"type",@"0", @"isActive",nil];
    //    NSDictionary *dic5 = [[NSDictionary alloc]initWithObjectsAndKeys:@"2", @"id", @"电器", @"type",@"0", @"isActive",nil];
    //    NSDictionary *dic6 = [[NSDictionary alloc]initWithObjectsAndKeys:@"3", @"id", @"生活用品", @"type",@"1", @"isActive",nil];
    //
    //    self.goodsTypeArray = [[NSArray alloc]initWithObjects:dic1, dic2, dic3, dic4, dic5, dic6,nil];
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

- (IBAction)changeAddress:(id)sender {
    //NSLog(@"changeAddress");
    NSString * firstName = self.firstAddress.titleLabel.text ;
    NSString * secondName = self.secondAddress.titleLabel.text ;
    
    if (![firstName isEqualToString:secondName]) {
        [self.firstAddress setTitle:secondName forState:UIControlStateNormal];
        [self.secondAddress setTitle:firstName forState:UIControlStateNormal];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.destinationViewController isKindOfClass:[DetailedAddressViewController class]])
    {
        DetailedAddressViewController *viewController = (DetailedAddressViewController *)segue.destinationViewController;
        viewController.delegate = self;
        NSInteger nType = 0;
        if ([segue.identifier isEqualToString:@"sourceAddress"])
        {
            nType = 0;
        }
        else if ([segue.identifier isEqualToString:@"targetAddress"]){
            nType = 1;
        }
        
        viewController.addressType = nType;
    }
    else if([segue.destinationViewController isKindOfClass:[ConfirmTableViewController class]]){
        NSLog(@"ConfirmTableViewController");
        
        //[self addParams];
        
        ConfirmTableViewController *viewController = (ConfirmTableViewController *)segue.destinationViewController;
        viewController.addOrderParams = _addOrderParams;
    }
}

-(void)addParams{
    NSNumber * numberType = [[NSNumber alloc]initWithInt:0];
    NSString * strGoodsName = self.goodsNameTF.text;
    NSString * strGoodsValue = self.goodsVaulesTF.text;
    CGFloat cgWeight = self.goodsWeight.text.floatValue;

    NSNumber * numberWeight = [[NSNumber alloc]initWithFloat:cgWeight];
    NSNumber * numberPgWay = [[NSNumber alloc]initWithInt:self.nPgWay];
    NSNumber * numberRgWay = [[NSNumber alloc]initWithInt:self.nRgWay];
    
    NSString * startTime = self.startTimeBtn.titleLabel.text;
    NSString * endTime = self.endTimeBtn.titleLabel.text;
    if (startTime == nil) {
        startTime = @"";
    }
    if (endTime == nil) {
        endTime = @"";
    }
    
    NSString * startAddress = self.firstAddress.titleLabel.text;
    NSString * endAddress = self.secondAddress.titleLabel.text;
    
    [_addOrderParams setObject: numberType forKey:@"type"];
    [_addOrderParams setObject: strGoodsName forKey:@"name"];
    [_addOrderParams setObject: strGoodsValue forKey:@"value"];
    [_addOrderParams setObject: numberWeight forKey:@"weight"];
    [_addOrderParams setObject: numberPgWay forKey:@"pgWay"];
    [_addOrderParams setObject: numberRgWay forKey:@"rgWay"];
    [_addOrderParams setObject: startTime forKey:@"rgStartTime"];
    [_addOrderParams setObject: endTime forKey:@"rgEndTime"];
    [_addOrderParams setObject: startAddress forKey:@"pgAddress"];
    [_addOrderParams setObject: endAddress forKey:@"rgAddress"];

}

-(void)setValue:(NSString *)address Type:(NSInteger)type{
    NSLog(@"address :%@ Type :%ld", address, (long)type);
    
    if (type == 0) {
        [self.firstAddress setTitle:address forState:UIControlStateNormal];
    }
    else{
        [self.secondAddress setTitle:address forState:UIControlStateNormal];
    }
    
}

- (IBAction)goodsTypeBtn:(id)sender {
    
    if (self.goodsTypeView == nil) {
        self.goodsTypeView = [[GoodsTypeView alloc]init];
        self.goodsTypeView.goodsTypeArray = _goodsTypeArray;
        self.goodsTypeView.delegate = self;
    }

    [self.goodsTypeView  showInView:self.view];
}

- (IBAction)pgWayBtn:(id)sender {
    if (self.deliveryWayView == nil) {
        self.deliveryWayView = [[DeliveryWayView alloc]init];
        self.deliveryWayView.delegate = self;
    }
    
    self.deliveryWayView.goodsStlyArray = _deliveryWayArray;
    self.deliveryWayView.typeStly = 0;
    [self.deliveryWayView showInView:self.view];
}


- (IBAction)rgWayClick:(id)sender {
    if (self.deliveryWayView == nil) {
        self.deliveryWayView = [[DeliveryWayView alloc]init];
        self.deliveryWayView.delegate = self;
    }
    
    self.deliveryWayView.goodsStlyArray = _consigneeWayArray;
    self.deliveryWayView.typeStly = 1;
    [self.deliveryWayView showInView:self.view];
}

- (IBAction)startTimeClick:(id)sender {
    
    if (self.timerPickerView == nil) {
        self.timerPickerView = [[TimerPickerView alloc]init];
        self.timerPickerView.delegate = self;
    }
    
    self.timerPickerView.index = 0;
    [self.timerPickerView showInView:self.view];
}

- (IBAction)endTimeClick:(id)sender {
    if (self.timerPickerView == nil) {
        self.timerPickerView = [[TimerPickerView alloc]init];
        self.timerPickerView.delegate = self;
    }
    
    self.timerPickerView.index = 1;
    [self.timerPickerView showInView:self.view];
}

- (void)pickerDidDateTime:(NSString *)strDate type:(NSUInteger)index{
    
    if (index == 0) {
        [self.startTimeBtn setTitle:strDate forState:UIControlStateNormal];
    }
    else{
        [self.endTimeBtn setTitle:strDate forState:UIControlStateNormal];
    }
    
}

- (void)pickerDidChaneStatus:(NSUInteger)nindex{
    //用户选择货物类型
    
    if(_goodsTypeArray != nil && nindex <= _goodsTypeArray.count){
        
        NSString * name = [_goodsTypeArray[nindex] valueForKey:@"type"];
        
        [_goodsTypeBtn setTitle:name forState:UIControlStateNormal];
        _goodsNameTF.text = name;
    }
    
    self.nGoodsType = nindex;
}

- (void)pickerDidChaneStly:(NSUInteger)nindex Type:(NSUInteger)type{
    if (type == 0) {
        //发件方式
        [self setPGWay:nindex];
        self.nPgWay = nindex;
    }
    else{
        //收件方式
        [self setRGWay:nindex];
        self.nPgWay = nindex;
    }
    
    
}

-(void)setPGWay:(NSInteger)stly{
    NSString * strStly = @"";
    
    strStly = self.deliveryWayArray[stly];
    
    [self.pgWay setTitle:strStly forState:UIControlStateNormal];
}

-(void)setRGWay:(NSInteger)stly{
    
    NSString * strStly = @"";
    
    strStly = self.consigneeWayArray[stly];
    
    [self.rgWayBtn setTitle:strStly forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    if ([self.goodsNameTF isFirstResponder])
    {
        [self.goodsVaulesTF becomeFirstResponder];
        
    }
    else if([self.goodsVaulesTF isFirstResponder])
    {
        [self.goodsWeight becomeFirstResponder];
    }
//    else if([fieldThree isFirstResponder])
//    {
//        [fieldOne becomeFirstResponder]; 
//        //NSLog(@"3-->1"); 
//    }
    
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
