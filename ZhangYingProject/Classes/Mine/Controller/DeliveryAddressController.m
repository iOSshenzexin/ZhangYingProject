//
//  DeliveryAddressController.m
//  ZhangYingProject
//
//  Created by 杨晓婧 on 16/7/25.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "DeliveryAddressController.h"
#import "DealCustomCell.h"
#import "SZXSelectProvinceView.h"
@interface DeliveryAddressController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,SZXSelectProvinceViewDelegate>
{
    NSInteger _provinceIndex;
    NSInteger _cityIndex;
    NSInteger _regionIndex;
}
@property (nonatomic,copy) NSArray *provinceArray;
@property (nonatomic,strong) UIPickerView *pickerView;

@property (nonatomic,copy) NSArray *placeholderArray;

@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation DeliveryAddressController
+(DeliveryAddressController *)sharedDeliveryAddressController{
    static DeliveryAddressController *vc = nil;
    if (!vc) {
        vc = [[DeliveryAddressController alloc] init];
    }
    return vc;
}

-(NSArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Province.plist" ofType:nil]];
    }
    return _provinceArray;
}

-(void)btnClickSelect:(SZXSelectProvinceView *)view andBtn:(UIBarButtonItem *)button{
    NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
    DealCustomCell *cell = [self.addressTableView cellForRowAtIndexPath:index];
    if (button.tag == 10) {
        cell.txtField.text = [NSString stringWithFormat:@"%@%@%@",self.provinceArray[_provinceIndex][@"province"],[self.provinceArray[_provinceIndex][@"citys"]objectAtIndex:_cityIndex][@"city"],[self.provinceArray[_provinceIndex][@"citys"]objectAtIndex:_cityIndex][@"districts"][_regionIndex]];
    }
    [cell.txtField resignFirstResponder];
}

- (void)refreshPickerView:(UIPickerView *)pickView{
    [pickView selectRow:_provinceIndex inComponent:0 animated:YES];
    [pickView selectRow:_cityIndex inComponent:1 animated:YES];
    [pickView selectRow:_regionIndex inComponent:2 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinceArray.count;
    }else if(component == 1){
        return [self.provinceArray[_provinceIndex][@"citys"] count];
    }else if(component == 2){
        NSArray *array = [self.provinceArray[_provinceIndex] objectForKey:@"citys"];
        return [[array[_cityIndex] objectForKey:@"districts"] count];
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lbl = (UILabel *)view;
    if (lbl == nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/3, 30)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.adjustsFontSizeToFitWidth = YES;
        lbl.font = [UIFont systemFontOfSize:16];
    }
    if (component == 0){
        lbl.text =  self.provinceArray [row][@"province"];
    }else if (component == 1){
        NSArray *array = [self.provinceArray[_provinceIndex] objectForKey:@"citys"];
        lbl.text =  [array[row] objectForKey:@"city"];
    }else{
        NSArray *array = [self.provinceArray[_provinceIndex] objectForKey:@"citys"];
        lbl.text =  [[array[_cityIndex] objectForKey:@"districts"] objectAtIndex:row];
    }
    return lbl;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.view.bounds.size.width/3-10;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _provinceIndex = row;
        _cityIndex = 0;
        _regionIndex = 0;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
    }else if (component ==1){
        _cityIndex = row;
        _regionIndex = 0;
        [pickerView reloadComponent:2];
        
    }else{
        _regionIndex = row;
    }
    [self refreshPickerView:pickerView];
}

- (IBAction)didClickSubmitAddress:(id)sender {
    NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
    DealCustomCell *cell = [self.addressTableView cellForRowAtIndexPath:index];
    NSIndexPath *indexOne = [NSIndexPath indexPathForRow:3 inSection:0];
    DealCustomCell *cellOne = [self.addressTableView cellForRowAtIndexPath:indexOne];
    self.address = [NSString stringWithFormat:@"%@%@",cell.txtField.text,cellOne.txtField.text];
    
    if ([self.delegate respondsToSelector:@selector(deliveryAddress:)]) {
        [self.delegate deliveryAddress:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
    [MBProgressHUD showSuccess:@"新增地址成功!"];
}

-(NSArray *)placeholderArray{
    if (!_placeholderArray) {
        _placeholderArray = [NSArray arrayWithObjects:@"请输入联系人姓名",@"请输入联系人手机号码",@"请选择地区",@"请输入详细地址", nil];
    }
    return _placeholderArray;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"联系人姓名",@"联系人手机",@"省/市/区",@"详细地址", nil];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.addressTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.addressTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self registerCell];
}

static NSString *cellID = @"cellId";
- (void)registerCell{
    UINib *nib = [UINib nibWithNibName:@"DealCustomCell" bundle:nil];
    [self.addressTableView registerNib:nib forCellReuseIdentifier:cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DealCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DealCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    cell.layer.borderWidth = 1;
    //    UIColor *color = [UIColor blackColor];
    //    //RGB(242, 242, 242, 1);
    //    cell.layer.borderColor = [color CGColor];
    cell.txtField.placeholder = self.placeholderArray[indexPath.row];
    if (indexPath.row == 2){
        cell.txtField.adjustsFontSizeToFitWidth = YES;
        SZXSelectProvinceView *keyBoardView = [SZXSelectProvinceView selectProvinceView];
        //
        keyBoardView.selectDelegate = self;
        [[cell.txtField valueForKey:@"textInputTraits"] setValue:[UIColor clearColor] forKey:@"insertionPointColor"];
       cell.txtField.inputView = keyBoardView;
        self.pickerView =  keyBoardView.provincePickerView;
        self.pickerView.delegate = self;
        [self refreshPickerView:self.pickerView];
    }
    cell.lbl.text = self.titleArray[indexPath.row];
    return cell;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.addressTableView resignFirstResponder];
    [self.view endEditing:YES];
}




@end