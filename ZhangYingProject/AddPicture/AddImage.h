//
//  AddImage.h
//  1
//
//  Created by 杨晓婧 on 15/12/5.
//  Copyright © 2015年 PS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddImageDelegate <NSObject>

- (NSInteger)getCount;

@end


@interface AddImage : UIView
@property (nonatomic, weak) id<AddImageDelegate>delegate;
/**
* 使用说明:直接创建此view添加到你需要放置的位置即可.
* 属性images可以获取到当前选中的所有图片对象.
*/

 /**
  *  存储所有的照片(UIImage)
  */
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,assign) int number;
- (void)addNew:(UIButton *)btn;
@property (nonatomic,strong) NSMutableArray *firstArray;

- (UIButton *)createButtonWithImage:(id)imageNameOrImage andSeletor : (SEL)selector;


 @end


