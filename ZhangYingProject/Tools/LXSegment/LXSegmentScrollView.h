//
//  LXSegmentScrollView.h
//  LiuXSegment
//
//  Created by liuxin on 16/5/17.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiuXSegmentView.h"

//typedef void(^DataBlock)(int selectedId);

typedef void(^DataBlock)(int selectedId);

typedef void (^testTFBlockParameter)(NSString *parameter1 , NSString *parameter2);


typedef void(^segmentBlock)(int selected);

@interface LXSegmentScrollView : UIView

-(instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray;

@property (nonatomic,copy) DataBlock block;

@property (nonatomic,strong) segmentBlock segBlock;

@property (strong,nonatomic) UIScrollView *bgScrollView;

@property (strong,nonatomic) LiuXSegmentView *segmentToolView;


@end
