//
//  TaskOrderUnfinished_OK_Cell.h
//  Post
//
//  Created by cheng on 15/4/24.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectUnfinishedIndexDelegate <NSObject>

-(void)SelectIndex:(NSUInteger)index;

@end

@interface TaskOrderUnfinished_OK_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *funtcionBtn;
- (IBAction)btnClick:(id)sender;

@property (assign, nonatomic) NSUInteger nState;
@property (weak, nonatomic) id<SelectUnfinishedIndexDelegate> delegate;

@end
