//
//  PhotoGroupView.m
//  Post
//
//  Created by cheng on 15/2/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "PhotoGroupView.h"
#import "UIButton+AFNetworking.h"

#define POST_PHOTOGROUPVIEW_ITEMHEIGHTSEP 5.0
#define POST_PHOTOGROUPVIEW_PHOTOCOUNT 5.0


@implementation PhotoGroupView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initLocalData];

        CGFloat lableHeight = 0.0;
        UILabel * lable = (UILabel *)[self viewWithTag:1000];
        if (lable != nil) {
            lableHeight = lable.frame.origin.y + lable.frame.size.height;
          
        }
        NSLog(@"%f, %f, %f", self.frame.size.width, self.frame.size.height, [UIScreen mainScreen].bounds.size.width);
        //UIView * backView = [view1 viewWithTag:1001];
        //if (backView != nil) {
        CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - POST_PHOTOGROUPVIEW_ITEMHEIGHTSEP * (POST_PHOTOGROUPVIEW_PHOTOCOUNT + 1)) / POST_PHOTOGROUPVIEW_PHOTOCOUNT;
        CGFloat itemHeight = itemWidth;
        
        CGFloat itemHorizontalSpacing = ([UIScreen mainScreen].bounds.size.width - (itemWidth * POST_PHOTOGROUPVIEW_PHOTOCOUNT)) / (POST_PHOTOGROUPVIEW_PHOTOCOUNT + 1);
        
        for (long nIndex = 0; nIndex < POST_PHOTOGROUPVIEW_PHOTOCOUNT; nIndex++) {
            
            CGFloat x = nIndex * itemWidth + (nIndex + 1) * itemHorizontalSpacing;
            CGFloat y = POST_PHOTOGROUPVIEW_ITEMHEIGHTSEP + lableHeight;
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, itemHeight, itemWidth)];
            [button setBackgroundImage:[UIImage imageNamed:@"ic_add_pic_normal.png"] forState:UIControlStateNormal];
            button.tag = nIndex;
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            [self.photoArray addObject:button];
            //            UIImageView * photo = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, itemHeight, itemWidth)];
            //            photo.image = [UIImage imageNamed:@"4-4SMART-BOX-消息_启动预警.png"];
            //            photo.tag = nIndex;
            //
            //            // 单击的 Recognizer
            //            UITapGestureRecognizer* singleRecognizer;
            //            singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
            //            //点击的次数
            //            singleRecognizer.numberOfTapsRequired = 1; // 单击
            //            //给UIImageView添加一个手势监测；
            //            [photo addGestureRecognizer:singleRecognizer];
            //            
            //            [self addSubview:photo];
            // }
            
        }
        NSLog(@"initWithCoder :%f,%f. %f", self.frame.size.width, self.frame.size.height, lableHeight);
        
//        NSLog(@"initWithCoder :%f,%f. %f", self.frame.size.width, self.frame.size.height, [UIScreen mainScreen].bounds.size.width);
//        
//        //CGFloat itemHeight = (self.frame.size.height - POST_PHOTOGROUPVIEW_ITEMHEIGHTSEP * 2) ;
//        CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - POST_PHOTOGROUPVIEW_ITEMHEIGHTSEP * (POST_PHOTOGROUPVIEW_PHOTOCOUNT + 1)) / POST_PHOTOGROUPVIEW_PHOTOCOUNT;
//        CGFloat itemHeight = itemWidth;
//        
//        CGFloat itemHorizontalSpacing = ([UIScreen mainScreen].bounds.size.width - (itemWidth * POST_PHOTOGROUPVIEW_PHOTOCOUNT)) / (POST_PHOTOGROUPVIEW_PHOTOCOUNT + 1);
//        
//        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//        [button setBackgroundImage:[UIImage imageNamed:@"4-4SMART-BOX-消息_启动预警.png"] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:button];
        
//        for (long nIndex = 0; nIndex < POST_PHOTOGROUPVIEW_PHOTOCOUNT; nIndex++) {
//            
//            CGFloat x = nIndex * itemWidth + (nIndex + 1) * itemHorizontalSpacing;
//            CGFloat y = POST_PHOTOGROUPVIEW_ITEMHEIGHTSEP;
//            
//            UIImageView * photo = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, itemHeight, itemWidth)];
//            photo.image = [UIImage imageNamed:@"4-4SMART-BOX-消息_启动预警.png"];
//            photo.tag = nIndex;
//            // 单击的 Recognizer
//            UITapGestureRecognizer* singleRecognizer;
//            singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
//            //点击的次数
//            singleRecognizer.numberOfTapsRequired = 1; // 单击
//            //给UIImageView添加一个手势监测；
//            [photo addGestureRecognizer:singleRecognizer];
//            
//            [self addSubview:photo];
//        }
        
//        self.backgroundColor = [UIColor redColor];
        
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
}

-(void)initLocalData{
    
    self.photoArray = [[NSMutableArray alloc]initWithCapacity:POST_PHOTOGROUPVIEW_PHOTOCOUNT];
    
}

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

-(void)updateConstraints{
    [super updateConstraints];
    
    
}

-(void)click:(id)sender{
    UIButton * btn = (UIButton *)sender;
    NSLog(@"click :%ld", (long)btn.tag);
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(selectPhotoIndex:)]) {
        [self.delegate selectPhotoIndex:btn.tag];
    }

}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    NSLog(@"index:%ld", (long)recognizer.view.tag);
}

-(void)setPhoto:(UIImage *)image byIndex:(NSInteger)index{
    UIButton * selectBtn = (UIButton *)_photoArray[index];
    if (selectBtn != nil) {
        [selectBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

-(void)setURLPhoto:(NSURL *)url byIndex:(NSInteger)index{
    
    UIButton * selectBtn = (UIButton *)_photoArray[index];
    if (selectBtn != nil) {
        //[selectBtn setBackgroundImage:image forState:UIControlStateNormal];
        [selectBtn setImageForState:UIControlStateNormal withURL:url];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
