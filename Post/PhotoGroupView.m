//
//  PhotoGroupView.m
//  Post
//
//  Created by cheng on 15/2/10.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "PhotoGroupView.h"


#define POST_PHOTOGROUPVIEW_ITEMHEIGHTSEP 5.0
#define POST_PHOTOGROUPVIEW_PHOTOCOUNT 5.0


@implementation PhotoGroupView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        
        NSLog(@"initWithCoder :%f,%f. %f", self.frame.size.width, self.frame.size.height, [UIScreen mainScreen].bounds.size.width);
        
        //CGFloat itemHeight = (self.frame.size.height - POST_PHOTOGROUPVIEW_ITEMHEIGHTSEP * 2) ;
        CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - POST_PHOTOGROUPVIEW_ITEMHEIGHTSEP * (POST_PHOTOGROUPVIEW_PHOTOCOUNT + 1)) / POST_PHOTOGROUPVIEW_PHOTOCOUNT;
        CGFloat itemHeight = itemWidth;
        
        CGFloat itemHorizontalSpacing = ([UIScreen mainScreen].bounds.size.width - (itemWidth * POST_PHOTOGROUPVIEW_PHOTOCOUNT)) / (POST_PHOTOGROUPVIEW_PHOTOCOUNT + 1);
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button setBackgroundImage:[UIImage imageNamed:@"4-4SMART-BOX-消息_启动预警.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
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
        
        self.backgroundColor = [UIColor redColor];
        
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
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
    NSLog(@"click");
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    //处理单击操作
    NSLog(@"index:%ld", (long)recognizer.view.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
