//
//  DetailedAddressViewController.m
//  Post
//
//  Created by cheng on 15/2/1.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "DetailedAddressViewController.h"
#import "HZAreaPickerView.h"
#import "BMapKit.h"

@implementation POIDataInfo

@end

@interface DetailedAddressViewController ()<UITextFieldDelegate, HZAreaPickerDelegate, BMKMapViewDelegate, BMKPoiSearchDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)HZAreaPickerView * pickCityView;
@property(nonatomic, strong)NSMutableString * searchString;

//地图poi搜索
@property(nonatomic, strong)BMKPoiSearch* poiSearch;
//保存查询poi点信息
@property(nonatomic, strong)NSMutableArray *BMKPoiInfoArray;

//tableview数据源 包含1 当前用户位置点 2 历史搜索数据 3 当前搜索poi点
@property(nonatomic, strong)NSMutableArray *poiTableViewData;

@property(nonatomic, strong)NSArray *poiCurrGPSData;
@property(nonatomic, strong)NSMutableArray *poiHistoryData;
@property(nonatomic, strong)NSMutableArray *poiSearchData;


@end

@implementation DetailedAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cityText.delegate = self;
    self.areaText.delegate = self;
    self.searchString = [[NSMutableString alloc]initWithCapacity:20];
    self.poiSearch = [[BMKPoiSearch alloc]init];
    self.BMKPoiInfoArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.addressTableView.delegate = self;
    self.addressTableView.dataSource = self;
    //self.addressType = 0;
    
    [self initLocalData];
    // Do any additional setup after loading the view.
}

-(void)initLocalData{
    
    POIDataInfo * UserGPS = [[POIDataInfo alloc]init];
    UserGPS.poiName = @"龙峰二路102号";
    UserGPS.address = @"广东省深圳市宝安区";

    POIDataInfo * historyData1 = [[POIDataInfo alloc]init];
    historyData1.poiName = @"广深高速公路";
    historyData1.address = @"广东省深圳市宝安区";
    
    POIDataInfo * historyData2 = [[POIDataInfo alloc]init];
    historyData2.poiName = @"深南大道9028号";
    historyData2.address = @"广东省深圳市宝安区";
    
    self.poiTableViewData = [[NSMutableArray alloc]initWithCapacity:3];
    self.poiCurrGPSData = [[NSArray alloc]initWithObjects:UserGPS, nil];
    self.poiHistoryData = [[NSMutableArray alloc]initWithObjects:historyData1, historyData2, nil];
    
    self.poiSearchData = [[NSMutableArray alloc]initWithCapacity:10];
    //NSInteger nCount = _poiSearchData.count;
    
    [self.poiTableViewData addObject:self.poiCurrGPSData];
    [self.poiTableViewData addObject:self.poiHistoryData];
    [self.poiTableViewData addObject:self.poiSearchData];
    
    //NSInteger nCount = _poiTableViewData.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancelLocatePicker
{
    [self.pickCityView cancelPicker];
    self.pickCityView.delegate = nil;
    self.pickCityView = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    _poiSearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewDidDisappear:(BOOL)animated{
    [self cancelLocatePicker];
    _poiSearch.delegate = nil; // 不用时，置nil
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    NSString * info;
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        info = [NSString stringWithFormat:@"%@",  picker.locate.district];
        if( [info length] == 0 )
        {
            info = [NSString stringWithFormat:@"%@",  picker.locate.city];
        }
    } else{
        info = [NSString stringWithFormat:@"%@, %@", picker.locate.state, picker.locate.city];
    }
    
    self.cityText.text = info;
    NSLog(@"%@", info);
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.cityText]) {
        [self cancelLocatePicker];
        self.pickCityView = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
        [self.pickCityView showInView:self.view];
        
        return NO;
    } else {
        [self.searchString setString:@""];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.areaText]) {
        NSLog(@"textfieldshouldreturn");
        [textField resignFirstResponder];
        
        [self serachPOIByCity:@"南山" address:@"清华信息港"];//self.cityText.text self.searchString
    }
    
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    if ([textField isEqual:self.areaText]) {
//        NSLog(@"%@", string);
//        if (string == nil || string.length <= 0) {
//            return YES;
//        }
//        int aCharacter = [string characterAtIndex:0];
//        if(aCharacter > 0x4e00 && aCharacter < 0x9fff){
//            [self.searchString appendString:string];
//            
//            [self serachPOIByCity:self.cityText.text address:self.searchString];
//        }
//        else{
//            //不是中文
//        }
//    }
    
//    return YES;
//}

- (void)textFieldDidChange:(NSNotification *)obj
{
    NSString * string = self.areaText.text;
    
    if (string == nil || string.length <= 0) {
        return;
    }
    int aCharacter = [string characterAtIndex:0];
    if(aCharacter > 0x4e00 && aCharacter < 0x9fff){
        [self.searchString appendString:string];

        NSLog(@"%@", string);
        //[self serachPOIByCity:self.cityText.text address:self.searchString];
    }
    else{
        //不是中文
    }
    
    
    
    //}
    //可以用note.object来获取产生该消息的UITextField
//    if (self.areaText.text.length > 0) {
//        int utfCode = 0;
//        void *buffer = &utfCode;
//        NSRange range = NSMakeRange(_activeTextField.text.length - 1, 1);
//        NSString *word = [_activeTextField.text substringWithRange:range];
//        BOOL b = [word getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
//        if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5)) {
//            NSLog(@"it is chinese,%@", word);
//        }
//    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing%@", textField.text);
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.areaText];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing%@", textField.text);
    
//     [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.areaText];
}

-(BOOL)serachPOIByCity:(NSString *)city address:(NSString *)address{
    int curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= city;
    citySearchOption.keyword = address;
    BOOL flag = [self.poiSearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功 城市:%@", city);
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
    
    return flag;
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    //清除之前的数据
    [_BMKPoiInfoArray removeAllObjects];
    if (error == BMK_SEARCH_NO_ERROR) {
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            [_BMKPoiInfoArray addObject:poi];
            NSLog(@"POI name:%@ address:%@ city:%@", poi.name, poi.address, poi.city);
        }
        
        //通知界面刷新
        if ([self upDataDownLoadPOI]) {
            [self reLoadTableViewData];
        }
        
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
        NSLog(@"onGetPoiResult Error:[%d]", error);
    }
}

-(BOOL)upDataDownLoadPOI{
    NSInteger nCount = _BMKPoiInfoArray.count;
    for (int nIndex = 0; nIndex < nCount; nIndex++) {
        //[self.poiSearchData]
        BMKPoiInfo* poi = _BMKPoiInfoArray[nIndex];
        POIDataInfo * Data = [[POIDataInfo alloc]init];
        Data.poiName = poi.name;
        Data.address = poi.address;
        
        [self.poiSearchData addObject:Data];
    }
    
    return nCount != 0 ? YES : NO;
}

-(void)reLoadTableViewData{
    [self.addressTableView reloadData];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
    [self.areaText resignFirstResponder];
}

//-(void)

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.poiTableViewData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSInteger nRow = 0;
    NSArray * array = self.poiTableViewData[section];
    if (array != nil) {
        nRow = array.count;
    }
    return nRow;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SettingItem"];
    
    if (cell != nil) {
        //NSDictionary * dict =  [[NSDictionary alloc]initWithDictionary:arraySettingItem[indexPath.row]];
        
        POIDataInfo * data = self.poiTableViewData[indexPath.section][indexPath.row];
        if (data != nil) {
        
            NSString * poiName = data.poiName;
            NSString * address = data.address;
            //NSLog(@"name :%@, icon :%@", name, icon);
            
            cell.textLabel.text = poiName;
            cell.detailTextLabel.text = address;
            //cell.imageView.image = [UIImage imageNamed:icon];
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath :%ld", (long)indexPath.row);
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell != nil) {
        self.areaText.text = cell.textLabel.text;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnClickGoback:(id)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(setValue:Type:)])
    {
        [self.delegate setValue:self.areaText.text Type:self.addressType];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
