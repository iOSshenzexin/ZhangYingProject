//
//  FloatingView.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/8/3.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "FloatingView.h"
#import "AppDelegate.h"
#import "RNGridMenu.h"

#import "ZXOnlineSeviceViewController.h"

#define MAINCOLOER [UIColor redColor]

#define kDownLoadWidth 52.5

#define kOffSet kDownLoadWidth / 2


@interface FloatingView ()<UIDynamicAnimatorDelegate,RNGridMenuDelegate>

@property (nonatomic , retain ) UIView *backgroundView;//背景视图

@property (nonatomic , retain ) UIImageView *imageView;//图片视图

@property (nonatomic , retain ) UIButton *floatingBtn;//按钮

@property (nonatomic , retain ) UIDynamicAnimator *animator;//物理仿真动画

@property (nonatomic,strong) RNGridMenu *av;
@end

@implementation FloatingView

-(instancetype)initWithFrame:(CGRect)frame{
    
    frame.size.width = kDownLoadWidth;
    
    frame.size.height = kDownLoadWidth;
    
    if (self = [super initWithFrame:frame]) {
        //初始化背景视图
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        
        _backgroundView.layer.cornerRadius = _backgroundView.frame.size.width / 2;
        
        _backgroundView.clipsToBounds = YES;
        
        _backgroundView.backgroundColor = MAINCOLOER;
        
        _backgroundView.userInteractionEnabled = NO;
        
        [self addSubview:_backgroundView];
        
        //初始化图片背景视图
        
        UIView * imageBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame) - 10, CGRectGetHeight(self.frame) - 10)];
        
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.size.width / 2;
        
        imageBackgroundView.clipsToBounds = YES;
        
        imageBackgroundView.backgroundColor = MAINCOLOER;
        
        imageBackgroundView.userInteractionEnabled = NO;
        
        [self addSubview:imageBackgroundView];
        //初始化图片
        
        _imageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"kf"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickFloatingImage:)];
        [_imageView addGestureRecognizer:tap];
        _imageView.frame = CGRectMake(0, 0,kDownLoadWidth, kDownLoadWidth);
        
        _imageView.center = CGPointMake(kDownLoadWidth / 2 , kDownLoadWidth / 2);
        
        [self addSubview:_imageView];
    }
    return self;
    
}


- (void)showGrid {
    NSInteger numberOfOptions = 2;
    NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"my-data04"] title:@"拨打电话"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"my-icon04"] title:@"在线咨询"]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    self.av = av;
    av.delegate = self;
    av.bounces = NO;
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    header.text = @"联系客服";
    header.font = [UIFont boldSystemFontOfSize:18];
    header.backgroundColor = [UIColor clearColor];
    header.textColor = [UIColor whiteColor];
    header.textAlignment = NSTextAlignmentCenter;
     av.headerView = header;
    [av showInViewController: self.window.rootViewController
 center:CGPointMake(ScreenW/2.f, ScreenH/2.f)];
   // [av showInViewController:self.window.rootViewController center:CGPointMake(ScreenW/2.f, ScreenH/2.f)];

}



- (void)didClickFloatingImage:(UITapGestureRecognizer *)tap{

        [self showGrid];
}


- (void)showGridWithHeaderFromPoint:(CGPoint)point {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"attachment"] title:@"Attach"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"bluetooth"] title:@"Bluetooth"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"cube"] title:@"Deliver"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"download"] title:@"Download"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"file"] title:@"Source Code"],
                       [RNGridMenuItem emptyItem]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.bounces = NO;
    av.animationDuration = 0.2;
    av.blurExclusionPath = [UIBezierPath bezierPathWithOvalInRect:self.imageView.frame];
    av.backgroundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, av.itemSize.width*3, av.itemSize.height*3)];
    
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    header.text = @"Example Header";
    header.font = [UIFont boldSystemFontOfSize:18];
    header.backgroundColor = [UIColor clearColor];
    header.textColor = [UIColor whiteColor];
    header.textAlignment = NSTextAlignmentCenter;
    av.headerView = header;
    
    [av showInViewController:self.window.rootViewController center:point];
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    if (itemIndex == 0) {
        UIWebView *callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:@"tel://400-666-8888"];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.superview addSubview:callWebview];
    }else
    {
        ZXOnlineSeviceViewController *vc = [[ZXOnlineSeviceViewController alloc] init];
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    }
    NSLog(@"Dismissed with item %zd: %@", itemIndex, item.title);
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //得到触摸点
    UITouch *startTouch = [touches anyObject];
    //返回触摸点坐标
    self.startPoint = [startTouch locationInView:self.superview];
    // 移除之前的所有行为
    [self.animator removeAllBehaviors];
}

//触摸移动

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //得到触摸点
    UITouch *startTouch = [touches anyObject];
    //将触摸点赋值给touchView的中心点 也就是根据触摸的位置实时修改view的位置
    self.center = [startTouch locationInView:self.superview];
}

//结束触摸

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //得到触摸结束点
    UITouch *endTouch = [touches anyObject];
    //返回触摸结束点
    self.endPoint = [endTouch locationInView:self.superview];
    //判断是否移动了视图 (误差范围5)
    CGFloat errorRange = 5;
    
    if (( self.endPoint.x - self.startPoint.x >= -errorRange && self.endPoint.x - self.startPoint.x <= errorRange ) && ( self.endPoint.y - self.startPoint.y >= -errorRange && self.endPoint.y - self.startPoint.y <= errorRange )) {
    } else {
        
        //移动
        
        self.center = self.endPoint;
        
        //计算距离最近的边缘 吸附到边缘停靠
        
        CGFloat superwidth = self.superview.bounds.size.width;
        
        CGFloat superheight = self.superview.bounds.size.height;
        
        CGFloat endX = self.endPoint.x;
        
        CGFloat endY = self.endPoint.y;
        
        CGFloat topRange = endY;//上距离
        
        CGFloat bottomRange = superheight - endY;//下距离
        
        CGFloat leftRange = endX;//左距离
        
        CGFloat rightRange = superwidth - endX;//右距离
        
        
        //比较上下左右距离 取出最小值
        
        CGFloat minRangeTB = topRange > bottomRange ? bottomRange : topRange;//获取上下最小距离
        
        CGFloat minRangeLR = leftRange > rightRange ? rightRange : leftRange;//获取左右最小距离
        
        CGFloat minRange = minRangeTB > minRangeLR ? minRangeLR : minRangeTB;//获取最小距离
        
        
        //判断最小距离属于上下左右哪个方向 并设置该方向边缘的point属性
        
        CGPoint minPoint;
        
        if (minRange == topRange) {
            
            //上
            
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            
            endX = endX + kOffSet > superwidth ? superwidth - kOffSet : endX;
            
            minPoint = CGPointMake(endX , 0 + kOffSet);
            
        } else if(minRange == bottomRange){
            
            //下
            
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            
            endX = endX + kOffSet > superwidth ? superwidth - kOffSet : endX;
            
            minPoint = CGPointMake(endX , superheight - kOffSet);
            
        } else if(minRange == leftRange){
            
            //左
            
            endY = endY - kOffSet < 0 ? kOffSet : endY;
            
            endY = endY + kOffSet > superheight ? superheight - kOffSet : endY;
            
            minPoint = CGPointMake(0 + kOffSet , endY);
            
        } else if(minRange == rightRange){
            
            //右
            
            endY = endY - kOffSet < 0 ? kOffSet : endY;
            
            endY = endY + kOffSet > superheight ? superheight - kOffSet : endY;
            
            minPoint = CGPointMake(superwidth - kOffSet , endY);
            
        }
        
        
        //添加吸附物理行为
        
        UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:minPoint];
        
        [attachmentBehavior setLength:0];
        
        [attachmentBehavior setDamping:0.1];
        
        [attachmentBehavior setFrequency:5];
        
        [self.animator addBehavior:attachmentBehavior];
        
        
    }
    
    
}

#pragma mark ---UIDynamicAnimatorDelegate

-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    
}

#pragma mark ---LazyLoading

- (UIDynamicAnimator *)animator{
    if (!_animator) {
        
        // 创建物理仿真器(ReferenceView : 仿真范围)
        
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
        
        //设置代理
        
        _animator.delegate = self;
        
    }
    
    return _animator;
    
}



#pragma mark ---BreathingAnimation 呼吸动画


- (void)HighlightAnimation{
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:1.5f animations:^{
        
        Self.backgroundView.backgroundColor = MAINCOLOER;
        
    } completion:^(BOOL finished) {
        
        [Self DarkAnimation];
        
    }];
    
}

- (void)DarkAnimation{
    
    __block typeof(self) Self = self;
    
    [UIView animateWithDuration:1.5f animations:^{
        
        Self.backgroundView.backgroundColor = MAINCOLOER;
        
    } completion:^(BOOL finished) {
        
        [Self HighlightAnimation];
        
    }];
    
}


@end
