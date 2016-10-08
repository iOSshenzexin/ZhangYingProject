//
//  LXSegmentScrollView.m
//  LiuXSegment
//
//  Created by liuxin on 16/5/17.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#define MainScreen_W [UIScreen mainScreen].bounds.size.width

#import "LXSegmentScrollView.h"

@interface LXSegmentScrollView()<UIScrollViewDelegate>
@property (nonatomic,copy) NSArray *titleArray;
@property (nonatomic,copy) NSArray *contentArray;

@end

@implementation LXSegmentScrollView

-(instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.bgScrollView];
        
        self.titleArray = titleArray;
        
        self.contentArray = contentViewArray;
        
        _segmentToolView=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_W, 44) titles:titleArray clickBlick:^void(NSInteger index) {
            self.block((int)index,MainScreen_W * (index - 1));
            ZXLog(@"ContentOffset %f",MainScreen_W * (index - 1));
            [_bgScrollView setContentOffset:CGPointMake(MainScreen_W * (index - 1), 0)];
        }];
        [self addSubview:_segmentToolView];
        
        for (NSInteger i = 0 ;i < contentViewArray.count; i++ ) {
            UIView *contentView = (UIView *)contentViewArray[i];
            contentView.frame = CGRectMake(MainScreen_W * i, _segmentToolView.bounds.size.height, MainScreen_W, _bgScrollView.frame.size.height - _segmentToolView.bounds.size.height);
            [self.bgScrollView addSubview: contentView];
        }
        self.bgScrollView.contentSize = CGSizeMake(MainScreen_W * (self.contentArray.count), self.bounds.size.height - _segmentToolView.bounds.size.height);
    }
    return self;
}


-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentToolView.frame.size.height, MainScreen_W , self.bounds.size.height - _segmentToolView.bounds.size.height)];
        _bgScrollView.showsVerticalScrollIndicator = NO;
        _bgScrollView.showsHorizontalScrollIndicator= NO;
        _bgScrollView.delegate = self;
        _bgScrollView.bounces = NO;
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.backgroundColor = backGroundColor;
    }
    return _bgScrollView;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _bgScrollView){
        if (_bgScrollView.contentOffset.x >= (self.titleArray.count)* MainScreen_W ){
           [_bgScrollView setContentOffset:CGPointMake(MainScreen_W *(self.titleArray.count - 1), 0)];
        }
        
        _segmentToolView.defaultIndex = _bgScrollView.contentOffset.x  / MainScreen_W + 1;
        
        
        CGFloat offsetX= _segmentToolView.titleBtn.frame.origin.x - 2 * _segmentToolView.titleBtn.frame.size.width;
        if (offsetX < 0) {
            offsetX = 0;
        }
        CGFloat maxOffsetX= _segmentToolView.bgScrollView.contentSize.width - [UIScreen mainScreen].bounds.size.width;
        if (offsetX > maxOffsetX) {
            offsetX = maxOffsetX;
        }
        self.block((int)_segmentToolView.defaultIndex,offsetX);

        [_segmentToolView.bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}



@end
