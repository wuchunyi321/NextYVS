//
//  MineCardAddViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/6.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineCardAddViewController.h"

@interface MineCardAddViewController ()<UITextFieldDelegate>{
    BOOL  isDefault;
}

@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UITextField *cardNumberField;
@property (nonatomic,strong)UITextField *phoneField;
@property (nonatomic,strong)UITextField *bankNameField;

@property (nonatomic,strong)UISwitch   *isChooseSwitch;

@end

@implementation MineCardAddViewController

- (UISwitch *)isChooseSwitch{
    if (!_isChooseSwitch) {
        _isChooseSwitch = [[UISwitch alloc] init];
        _isChooseSwitch.on = YES;
        _isChooseSwitch.tintColor = UIColorFromRGB(0x959595);
        _isChooseSwitch.onTintColor = RGBCOLOR(255, 52, 58);
        [_isChooseSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _isChooseSwitch;
}

- (void)valueChanged:(id)sender{
    _isChooseSwitch.on = !_isChooseSwitch.on;
    isDefault = !isDefault;
}

- (UITextField *)nameField{
    if (!_nameField) {
        _nameField = [[UITextField alloc] init];
        _nameField.backgroundColor = [UIColor whiteColor];
        _nameField.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _nameField.delegate = self;
        _nameField.textColor = RGBCOLOR(99, 99, 99);
        _nameField.placeholder = @"请输入姓名";
        _nameField.textAlignment = NSTextAlignmentLeft;
        UIView *leftView = [UIView new];
        leftView.frame = CGRectMake(0, 0, 100, 44);
        UILabel *titleLabel = [UILabel new];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"开户姓名";
        titleLabel.textColor = RGBCOLOR(37, 37, 37);
        titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
        titleLabel.frame = CGRectMake(16, 0, 80, 44);
        [leftView addSubview:titleLabel];
        _nameField.leftView = leftView;
        _nameField.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return _nameField;
}

- (UITextField *)cardNumberField{
    if (!_cardNumberField) {
        _cardNumberField = [[UITextField alloc] init];
        _cardNumberField.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _cardNumberField.backgroundColor = [UIColor whiteColor];
        _cardNumberField.delegate = self;
        _cardNumberField.textColor = RGBCOLOR(99, 99, 99);
        _cardNumberField.placeholder = @"请输入银行卡号";
        _cardNumberField.textAlignment = NSTextAlignmentLeft;
        UIView *leftView = [UIView new];
        leftView.frame = CGRectMake(0, 0, 100, 44);
        UILabel *titleLabel = [UILabel new];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"银行卡号";
        titleLabel.textColor = RGBCOLOR(37, 37, 37);
        titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
        titleLabel.frame = CGRectMake(16, 0, 80, 44);
        [leftView addSubview:titleLabel];
        _cardNumberField.leftView = leftView;
        _cardNumberField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _cardNumberField;
}

- (UITextField *)phoneField{
    if (!_phoneField) {
        _phoneField = [[UITextField alloc] init];
        _phoneField.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _phoneField.backgroundColor = [UIColor whiteColor];
        _phoneField.delegate = self;
        _phoneField.textColor = RGBCOLOR(99, 99, 99);
        _phoneField.placeholder = @"请输入预留手机号";
        _phoneField.textAlignment = NSTextAlignmentLeft;
        UIView *leftView = [UIView new];
        leftView.frame = CGRectMake(0, 0, 100, 44);
        UILabel *titleLabel = [UILabel new];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"预留手机号";
        titleLabel.textColor = RGBCOLOR(37, 37, 37);
        titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
        titleLabel.frame = CGRectMake(16, 0, 80, 44);
        [leftView addSubview:titleLabel];
        _phoneField.leftView = leftView;
        _phoneField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _phoneField;
}

- (UITextField *)bankNameField{
    if (!_bankNameField) {
        _bankNameField = [[UITextField alloc] init];
        _bankNameField.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:12];
        _bankNameField.backgroundColor = [UIColor whiteColor];
        _bankNameField.delegate = self;
        _bankNameField.textColor = RGBCOLOR(99, 99, 99);
        _bankNameField.placeholder = @"请输入银行名称";
        _bankNameField.textAlignment = NSTextAlignmentLeft;
        UIView *leftView = [UIView new];
        leftView.frame = CGRectMake(0, 0, 100, 44);
        UILabel *titleLabel = [UILabel new];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"银行名称";
        titleLabel.textColor = RGBCOLOR(37, 37, 37);
        titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
        titleLabel.frame = CGRectMake(16, 0, 80, 44);
        [leftView addSubview:titleLabel];
        _bankNameField.leftView = leftView;
        _bankNameField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _bankNameField;
}


- (void)initTheView{
    [self.view addSubview:self.bankNameField];
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.cardNumberField];
    [self.view addSubview:self.phoneField];
    
    [self.bankNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(TopHeight);
        make.height.mas_equalTo(44);
    }];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.bankNameField.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.cardNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.nameField.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.cardNumberField.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    UIView *switchView = [[UIView alloc] init];
    switchView.backgroundColor = [UIColor whiteColor];
    switchView.userInteractionEnabled = YES;
    [self.view addSubview:switchView];
    
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.phoneField.mas_bottom);
    }];
    
    UILabel *switchTitleLabel = [UILabel new];
    switchTitleLabel.textAlignment = NSTextAlignmentLeft;
    switchTitleLabel.text = @"设为默认";
    switchTitleLabel.textColor = RGBCOLOR(37, 37, 37);
    switchTitleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    switchTitleLabel.frame = CGRectMake(16, 0, 80, 44);
    [switchView addSubview:switchTitleLabel];
    
    [switchView addSubview:self.isChooseSwitch];
    [self.isChooseSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(switchView);
        make.height.mas_equalTo(20);
        make.right.equalTo(switchView.mas_right).offset(-16);
        make.width.mas_equalTo(45);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn addTarget:self action:@selector(handleOK) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:16];
    sureBtn.layer.cornerRadius = 20;
    sureBtn.layer.masksToBounds = YES;
    sureBtn.backgroundColor = RGBCOLOR(255, 52, 58);
    [self.view addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.height.mas_equalTo(44);
        make.top.equalTo(switchView.mas_bottom).offset(85);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isDefault = YES;
    // Do any additional setup after loading the view.
    [self initTheView];
}

- (void)handleOK{
    [JKRequest requestMoneyCardAdd:self.nameField.text.trime
                        cardNumber:self.cardNumberField.text.trime
                          bankName:self.bankNameField.text.trime
                      reservePhone:self.phoneField.text.trime
                         isDefault:[NSString stringWithFormat:@"%d",isDefault]
                           success:^(id responseObject) {
                               if (self.backBlock) {
                                   self.backBlock();
                               }
                               [self.navigationController popViewControllerAnimated:YES];
                           }
                           failure:^(NSString *errorMessage,id responseObject) {
                               JK_HUD_NO(errorMessage);
                           }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.bankNameField resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.cardNumberField resignFirstResponder];
    [self.phoneField resignFirstResponder];
}

@end
