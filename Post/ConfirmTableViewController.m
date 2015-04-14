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
@implementation structPhotoInfo


@end

@interface ConfirmTableViewController () <getPhotoInfoDelegate, photoGroupDelegate>
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
    selectPhotoIndex = -1;
    
    self.photoInfoCell.delegate = self;
    
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

- (IBAction)costTypeClick:(id)sender {
}
@end
