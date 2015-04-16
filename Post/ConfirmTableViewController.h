//
//  ConfirmTableViewController.h
//  Post
//
//  Created by cheng on 15/2/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface structPhotoInfo : NSObject

@property(nonatomic, assign)BOOL isPhoto;
@property(nonatomic, strong)UIImage * image;

@end

@class PaymentMethodView;

@interface ConfirmTableViewController : UITableViewController

@property (strong,nonatomic) PaymentMethodView * paymentMethodView;
@property (weak, nonatomic) IBOutlet UIView *PhotoGroupView;
@property (weak, nonatomic) IBOutlet UILabel *deliveryCost;
- (IBAction)costTypeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *consignerTF;
@property (weak, nonatomic) IBOutlet UITextField *consignerPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *consigneeTF;
@property (weak, nonatomic) IBOutlet UITextField *consigneePhoneTF;
- (IBAction)payWayClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *payWayBtn;
@property(strong, nonatomic) NSArray * arrayPayWay;

@property (strong, nonatomic) NSMutableDictionary * addOrderParams;


@end
