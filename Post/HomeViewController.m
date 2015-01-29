//
//  HomeViewController.m
//  Post
//
//  Created by wangsl-iMac on 15/1/28.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "HomeViewController.h"
#import "Custom_ScrollImageView.h"

@interface HomeViewController ()<CustromScrollImageViewTapDelegate>

@property(nonatomic, strong)Custom_ScrollImageView * srcollImage;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
}

-(void)viewDidLayoutSubviews{
    
    NSString *str1 = @"1.jpg";
    NSString *str2 = @"2.jpg";
    NSString *str3 = @"3.jpg";
    NSString *str4 = @"4.jpg";
    
    NSArray * array = @[str1, str2, str3, str4];
    
    static BOOL bFirst = NO;
    if (!bFirst) {
        bFirst = YES;
        
        self.srcollImage = [[Custom_ScrollImageView alloc]initWithFrame:self.cellForScrollView.frame  picArray:array];
        self.srcollImage.delegate = self;
        [self.cellForScrollView addSubview:self.srcollImage];
        [_srcollImage upDataScrollViewPoint];
    }

    NSLog(@"viewDidLayoutSubviews");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置tableview头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(void)ScrollImageViewdidSelectRowAtIndexPath:(NSInteger)index{
    NSLog(@"ScrollImageViewdidSelectRowAtIndexPath :%ld", (long)index);
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
