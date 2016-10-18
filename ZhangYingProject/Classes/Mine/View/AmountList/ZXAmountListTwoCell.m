//
//  ZXAmountListTwoCell.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/10/17.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXAmountListTwoCell.h"

@implementation ZXAmountListTwoCell

//-(void)setFrame:(CGRect)frame
//{
//    frame.size.height -= 2;
//    [super setFrame:frame];
//}

NSString *const amountListTwoCell = @"amountListTwoCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    ZXAmountListTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:amountListTwoCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXAmountListTwoCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

-(void)setAccountModel:(ZXAccountInfoModel *)accountModel
{
    _accountModel = accountModel;
    self.cardInfo.text = [NSString stringWithFormat:@"%@  %@",accountModel.bankName,accountModel.bankBranch];
    self.cardNumber.text = accountModel.bankCard;
    if ([accountModel.isDefault intValue] == 1) {
        self.defaultImage.hidden = NO;
    }else{
        self.defaultImage.hidden = YES;
    }
    
}

@end
