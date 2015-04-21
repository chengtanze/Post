//
//  PeripheralsTableViewController.m
//  Post
//
//  Created by wangsl-iMac on 15/3/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "PeripheralsTableViewController.h"
#import "MapPulicFunction.h"
#import "WWSideslipViewController.h"
#import "HttpProtocolAPI.h"
#import "AroundCityGoods_Cell.h"
#import "UIImageView+AFNetworking.h"
//#import "sqlite3.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface PeripheralsTableViewController ()

@end

@implementation PeripheralsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 200;
    
    [self initLocalData];
    
    [[HttpProtocolAPI sharedClient]getOrderByCityId:77 setBlock:^(NSDictionary *data, NSError *error) {
        if (data != nil) {
            self.arrayAroundData = [data valueForKey:@"data"];
            
            if(![self.arrayAroundData respondsToSelector:@selector(objectAtIndex:)])
            {
                NSLog(@"is null");
                self.arrayAroundData = nil;
            }
            
            if (self.arrayAroundData != nil && self.arrayAroundData.count > 0) {
                [self.tableView reloadData];
            }
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

-(void)initLocalData{
    //sqlite3 *database;
    //int result = sqlite3_open("/path/databaseFile", &database);
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDir = [paths objectAtIndex:0];
//    NSString *str = [documentsDir stringByAppendingPathComponent:@"Contacts.sqlite"];
    
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"china_city.db" ofType:nil];

    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"citydict.plist"
                                                   ofType:nil];
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory ,  NSUserDomainMask ,  YES );
    NSString* documentPath = [ paths objectAtIndex: 0 ];
    
    NSString* dbPath = [ documentPath stringByAppendingPathComponent: @"china_city.db" ];
    
    FMDatabase * database = [FMDatabase databaseWithPath: dbPath ];
    if ( ![database open] )
    {
        return;
    }
    
    // 查找表 AllTheQustions
    FMResultSet* resultSet = [ database executeQuery: @"SELECT * FROM area" ];
    
    // 逐行读取数据
    while ( [ resultSet next ] )
    {
        // 对应字段来取数据
        NSString* history = [ resultSet stringForColumn: @"History" ];
        NSString* question = [ resultSet stringForColumn: @"Question" ];
        NSLog( @"history: %@ , question: %@" , history , question );
    }
    
//    int result = sqlite3_open(path.UTF8String, &database);
//    if (result == SQLITE_OK) {
//        NSString *query = @"SELECT * FROM area";
//        sqlite3_stmt *statement;
//        int resultQuery = sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
//        if (resultQuery == SQLITE_OK) {
//            while (sqlite3_step(statement) == SQLITE_ROW) {
//                int rowNum = sqlite3_column_int(statement, 0);
//                char *rowData = (char *)sqlite3_column_text(statement, 1);
//                NSString *fieldValue = [[NSString alloc] initWithUTF8String:rowData];
//                // Do something with the data here
//            }
//        }
//    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    //return 5;
    return (self.arrayAroundData != nil ? self.arrayAroundData.count : 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AroundCityGoods_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityOrder_Cell" forIndexPath:indexPath];
    
    if (cell != nil) {
        NSDictionary * dicData = self.arrayAroundData[indexPath.row];
        
        if (dicData) {
            cell.goodsNameLB.text = [dicData valueForKey:@"name"];
            cell.startTimesLB.text = [dicData valueForKey:@"rgStartTime"];
            cell.endTimesLB.text = [dicData valueForKey:@"rgEndTime"];
            cell.startAddressLB.text = [dicData valueForKey:@"pgAddress"];
            cell.endAddressLB.text = [dicData valueForKey:@"rgAddress"];
            
            //发货经纬度
            NSNumber * pgLon = [dicData valueForKey:@"pgLongitude"];
            CGFloat pgLongitude = pgLon.floatValue;
            NSNumber * pgLat = [dicData valueForKey:@"pgLatitude"];
            CGFloat pgLatitude = pgLat.floatValue;
            
            NSNumber * rgLon = [dicData valueForKey:@"rgLongitude"];
            CGFloat rgLongitude = rgLon.floatValue;
            NSNumber * rgLat = [dicData valueForKey:@"rgLongitude"];
            CGFloat rgLatitude = rgLat.floatValue;

            
            NSDictionary * dicImage = [dicData valueForKey:@"goodsImg"];
            if (dicImage != nil) {
                NSString * strImage =  [dicImage valueForKey:@"imgUrl"][0];
                
                NSURL * url = [[NSURL alloc]initWithString:strImage];
                [cell.goodsImage setImageWithURL:url];
                NSLog(@"%@", strImage);
            }

        }
    }
    // Configure the cell...
    
    return cell;
}

-(void)viewDidAppear:(BOOL)animated
{
    WWSideslipViewController * sides = [WWSideslipViewController sharedInstance:nil andMainView:nil andRightView:nil andBackgroundImage:nil];
    
    [sides addPanGsetureToHomeView];
    NSLog(@"viewDidAppear");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    WWSideslipViewController * sides = [WWSideslipViewController sharedInstance:nil andMainView:nil andRightView:nil andBackgroundImage:nil];
    
    [sides removeGestureToHomeView];
    
    NSLog(@"prepareForSegue");
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
