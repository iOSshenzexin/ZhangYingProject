//
//  MessageDetailController.h
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UIImageView *contentImg;


@property (weak, nonatomic) IBOutlet UITextView *contentTxt;

@property (nonatomic,copy) NSString *message_id;



@end
