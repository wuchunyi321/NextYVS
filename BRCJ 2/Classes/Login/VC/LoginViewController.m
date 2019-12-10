//
//  LoginViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/30.
//  Copyright © 2019 cy. All rights reserved.
//

#import "LoginViewController.h"
#import <YYText/YYText.h>
#import "AppDelegate+RootVC.h" //切换登录状态
#import "MyMember.h"
#import "AcountModel.h"

#define bgHeight 222*mulNumber
#define logoImageWidth 120*mulNumber
/** 为了适配，需要调节这个值 **/
#define bottomToLabel_5  70*mulNumber

@interface LoginViewController ()<UITextFieldDelegate>{
    NSTimer   *timer;
    NSInteger  remainTime;
}

/** 是注册还是登录页面 ，yes是登录，no是注册，默认yes**/
@property (nonatomic,assign)BOOL   loginType;

/** 邀请码填写 **/
@property (nonatomic,strong)UITextField *inviteCodeTextField;
@property (nonatomic,strong)UIView      *inviteUnderLine;
/** 手机号填写 **/
@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UIView      *phoneUnderLine;
/** 验证码填写 **/
@property (nonatomic,strong)UITextField *veriCodeTextField;
@property (nonatomic,strong)UIView      *veriCodeUnderLine;

/** 注册和登录页面的切换 **/
@property (nonatomic,strong)YYLabel  *transferLabel;

/** 注册或者登录按钮 **/
@property (nonatomic,strong)UIButton *enterBtn;

/** 验证码的时间器 **/
//@property (nonatomic,strong)

/** 验证码按钮 **/
@property (nonatomic,strong)UIButton  *verBtn;

@end

@implementation LoginViewController

/** 获取验证码 **/
- (void)handleGetVer:(id)sender{
    if (self.phoneTextField.text.trime.length != 11) {
        JK_HUD_NO(@"手机号格式不对，请重新填写");
        return;
    }
    
    if (timer) {
        [timer invalidate];
    }
    
    if (self.loginType == YES) { //登录
        [JKRequest requestSMSCodeWithPhoneNum:self.phoneTextField.text.trime smsType:@0 success:^(id responseObject) {
            JK_HUD_YES(@"验证码发送成功");
            self->timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTheRemainTime:) userInfo:nil repeats:YES];
            self.verBtn.enabled = NO;
            [[NSRunLoop currentRunLoop] addTimer:self->timer forMode:NSRunLoopCommonModes];
            [self->timer fire];
        } failure:^(NSString *errorMessage,id responseObject) {
            JK_HUD_NO(errorMessage);
        }];
    }else{ //注册
        [JKRequest requestSMSCodeWithPhoneNum:self.phoneTextField.text.trime smsType:@1 success:^(id responseObject) {
            JK_HUD_YES(@"验证码发送成功");
            self->timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTheRemainTime:) userInfo:nil repeats:YES];
            self.verBtn.enabled = NO;
            [[NSRunLoop currentRunLoop] addTimer:self->timer forMode:NSRunLoopCommonModes];
            [self->timer fire];
        } failure:^(NSString *errorMessage,id responseObject) {
            JK_HUD_NO(errorMessage);
        }];
    }
}

- (UIButton *)verBtn{
    if (!_verBtn) {
        _verBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_verBtn addTarget:self action:@selector(handleGetVer:) forControlEvents:UIControlEventTouchUpInside];
        [_verBtn setTitleColor:RGBCOLOR(133, 133, 133) forState:UIControlStateNormal];
        [_verBtn setTitleColor:UIColorFromRGB(0x2d2d2d) forState:UIControlStateDisabled];
        [_verBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        _verBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:10];
        _verBtn.layer.borderColor = RGBCOLOR(209, 209, 209).CGColor;
        _verBtn.layer.borderWidth = 0.5;
        _verBtn.enabled = YES;
    }
    return _verBtn;
}

/** 每1s调用一次 **/
- (void)updateTheRemainTime:(id)sender{
    remainTime --;
    if (remainTime <1){
        remainTime = 60;
        [self.verBtn setTitle:@"再次获取" forState:UIControlStateNormal];
        self.verBtn.enabled = YES;
        [timer invalidate];
    }else{
        [self.verBtn setTitle:[NSString stringWithFormat:@"%lds",(long)remainTime] forState:UIControlStateDisabled];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (UITextField *)inviteCodeTextField{
    if (!_inviteCodeTextField) {
        _inviteCodeTextField = [[UITextField alloc] init];
        _inviteCodeTextField.textAlignment = NSTextAlignmentLeft;
        _inviteCodeTextField.placeholder = @"请输入您的邀请码";
        _inviteCodeTextField.backgroundColor = [UIColor clearColor];
        _inviteCodeTextField.textColor = RGBCOLOR(37, 37, 37);
        _inviteCodeTextField.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
        _inviteCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIView *leftView = [UIView new];
        leftView.backgroundColor = [UIColor clearColor];
        leftView.frame = CGRectMake(0, 0, 27, 43);
        
        UIImageView *image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"BRSource.bundle/login_invite"];
        image.frame = CGRectMake(5, (43-17)/2, 17, 17);
        [leftView addSubview:image];
        _inviteCodeTextField.leftView = leftView;
        _inviteCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _inviteCodeTextField;
}

- (UIView *)inviteUnderLine{
    if (!_inviteUnderLine) {
        _inviteUnderLine = [UIView new];
        _inviteUnderLine.backgroundColor = RGBCOLOR(209, 209, 209);
    }
    return _inviteUnderLine;
}

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        _phoneTextField.placeholder = @"请输入您的手机号码";
        _phoneTextField.backgroundColor = [UIColor clearColor];
        _phoneTextField.textColor = RGBCOLOR(37, 37, 37);
        _phoneTextField.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        UIView *leftView = [UIView new];
        leftView.backgroundColor = [UIColor clearColor];
        leftView.frame = CGRectMake(0, 0, 25, 43);
        
        UIImageView *image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"BRSource.bundle/login_phone"];
        image.frame = CGRectMake(5, (43-17)/2, 15, 17);
        [leftView addSubview:image];
        
        _phoneTextField.leftView = leftView;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _phoneTextField;
}

- (UIView *)phoneUnderLine{
    if (!_phoneUnderLine) {
        _phoneUnderLine = [UIView new];
        _phoneUnderLine.backgroundColor = RGBCOLOR(209, 209, 209);
    }
    return _phoneUnderLine;
}

- (UITextField *)veriCodeTextField{
    if (!_veriCodeTextField) {
        _veriCodeTextField = [[UITextField alloc] init];
        _veriCodeTextField.textAlignment = NSTextAlignmentLeft;
        _veriCodeTextField.placeholder = @"请输入您的验证码";
        _veriCodeTextField.backgroundColor = [UIColor clearColor];
        _veriCodeTextField.textColor = RGBCOLOR(37, 37, 37);
        _veriCodeTextField.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
        _veriCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
        UIView *leftView = [UIView new];
        leftView.backgroundColor = [UIColor clearColor];
        leftView.frame = CGRectMake(0, 0, 23, 43);
        
        UIImageView *image = [[UIImageView alloc] init];
        image.image = [UIImage imageNamed:@"BRSource.bundle/login_code"];
        image.frame = CGRectMake(5, (43-15)/2, 13, 15);
        [leftView addSubview:image];
        
        _veriCodeTextField.leftView = leftView;
        _veriCodeTextField.leftViewMode = UITextFieldViewModeAlways;
        
        self.verBtn.frame = CGRectMake(0, 10, 60, 20);
        _veriCodeTextField.rightView = self.verBtn;
        _veriCodeTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _veriCodeTextField;
}

- (UIView *)veriCodeUnderLine{
    if (!_veriCodeUnderLine) {
        _veriCodeUnderLine = [UIView new];
        _veriCodeUnderLine.backgroundColor = RGBCOLOR(209, 209, 209);
    }
    return _veriCodeUnderLine;
}

- (YYLabel *)transferLabel{
    if (!_transferLabel) {
        _transferLabel = [[YYLabel alloc] init];
    }
    return _transferLabel;
}

/** 点击注册或者登录按钮**/
- (void)handleEnter:(id)sender{
    
    if (self.phoneTextField.text.trime.length != 11) {
        JK_HUD_NO(@"手机号格式不对，请重新填写");
        return;
    }
    
    if (self.loginType) { //登录
        [JKRequest requestLoginWithPhoneNum:self.phoneTextField.text.trime
                                    smsCode:self.veriCodeTextField.text.trime
                                    success:^(id responseObject) {
                                        if ([UserContext isLogin]) {
                                                AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                                [delegate setMemberRootViewControllers];
                                                [delegate setAlias];
                                        }else{
                                            JK_HUD_NO(@"登录有误");
                                        }
                                    }
                                    failure:^(NSString *errorMessage,id responseObject) {
                                        JK_HUD_NO(errorMessage);
                                    }];
        
    }else{ //注册
        [JKRequest requestRegisterWithUserName:self.phoneTextField.text.trime
                                    Invitation:self.inviteCodeTextField.text.trime
                                       smsCode:self.veriCodeTextField.text.trime
                                       success:^(id responseObject) {
            
            if ([UserContext isLogin]) {
                AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate setMemberRootViewControllers];
                [delegate setAlias];
            }else{
                JK_HUD_NO(@"注册有误,请稍后重试");
            }
        } failure:^(NSString *errorMessage,id responseObject) {
            JK_HUD_NO(errorMessage);
        }];
    }
}

- (UIButton *)enterBtn{
    if (!_enterBtn) {
        _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterBtn.backgroundColor = RGBCOLOR(255, 52, 28);
        _enterBtn.layer.cornerRadius = 20;
        _enterBtn.layer.shadowColor = RGBCOLOR(230, 33, 39).CGColor;
        _enterBtn.layer.shadowOffset = CGSizeMake(0, 3);
        _enterBtn.layer.shadowOpacity = 0.5;
        _enterBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:16];
        [_enterBtn addTarget:self action:@selector(handleEnter:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}

- (void)initTheView{

    /** 顶部+logo部分 **/
    UIImageView  *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"BRSource.bundle/login_bg"];
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(bgHeight);
    }];
    
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.layer.shadowColor = UIColorFromRGB(0x7867ff).CGColor;
    logoImage.layer.shadowOffset = CGSizeMake(0, 3);
    logoImage.layer.shadowOpacity = 0.16;//阴影透明度，默认0
    logoImage.layer.shadowRadius = 3;//阴影半径，默认3
    [self.view addSubview:logoImage];
    logoImage.image = [UIImage imageNamed:@"BRSource.bundle/login_logo"];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(logoImageWidth);
        make.bottom.equalTo(bgView).offset(logoImageWidth/2);
    }];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.textColor = RGBCOLOR(255,52,58);
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:24];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"云世界";
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(logoImage.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    /** 底部登录按钮以及跳转注册部分 **/
    [self.view addSubview:self.transferLabel];
    self.transferLabel.userInteractionEnabled = YES;
    self.transferLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.enterBtn];
    
    [self.transferLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomToLabel_5);
        make.left.right.centerX.equalTo(self.view);
        make.height.mas_equalTo(15);
    }];
    
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(32);
        make.right.equalTo(self.view).offset(-32);
        make.bottom.equalTo(self.transferLabel.mas_top).offset(-32);
        make.height.mas_equalTo(40);
    }];
    
    /** 中间的输入部分 **/
    [self.view addSubview:self.inviteCodeTextField];
    [self.inviteCodeTextField addSubview:self.inviteUnderLine];
    [self.view addSubview:self.phoneTextField];
    [self.phoneTextField addSubview:self.phoneUnderLine];
    [self.view addSubview:self.veriCodeTextField];
    [self.veriCodeTextField addSubview:self.veriCodeUnderLine];

    CGFloat  bottomToTop = 20;
    if (iPhone6) {
        bottomToTop = 40;
    }else if (iPhone6Plus){
        bottomToTop = 60;
    }else if (iPhoneX || iPhoneXR){
        bottomToTop = 100;
    }
    [self.veriCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(55);
        make.right.equalTo(self.view).offset(-55);
        make.bottom.equalTo(self.enterBtn.mas_top).offset(-bottomToTop);
        make.height.mas_equalTo(40);
    }];

    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(55);
        make.right.equalTo(self.view).offset(-55);
        make.bottom.equalTo(self.veriCodeTextField.mas_bottom).offset(-44);
        make.height.mas_equalTo(40);
    }];

    [self.inviteCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(55);
        make.right.equalTo(self.view).offset(-55);
        make.bottom.equalTo(self.phoneTextField.mas_bottom).offset(-44);
        make.height.mas_equalTo(40);
    }];
    
    [self.veriCodeUnderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.veriCodeTextField);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.phoneUnderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.phoneTextField);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.inviteUnderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.inviteCodeTextField);
        make.height.mas_equalTo(0.5);
    }];
    
    /** 登录模式下的显示 **/
    [self transferToLogin];
}
/** 点击切换到登录模式下的显示 **/
- (void)transferToLogin{
    /** 初始化 **/
    if (timer) {
        [timer invalidate];
    }
    self.verBtn.enabled = YES;
    remainTime = 60;
    ////
    self.inviteCodeTextField.hidden = YES;
    self.inviteUnderLine.hidden = YES;
    NSMutableAttributedString  *attriText = [[NSMutableAttributedString alloc] initWithString:@"快速注册"];
    [attriText addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(255, 52, 58) range:NSMakeRange(0,4)];
    [attriText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 4)];
    [attriText yy_setTextHighlightRange:NSMakeRange(0, 4) color:RGBCOLOR(255, 52, 58) backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        /** 点击事件 **/
        if (self.loginType == YES) {
            [self transferToRegister];
        }else{
            [self transferToLogin];
        }
        self.loginType = !self.loginType;
    }];
    self.transferLabel.attributedText = attriText;
    self.transferLabel.textAlignment = NSTextAlignmentCenter;
    [self.enterBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
/** 点击切换到注册模式下的显示 **/
- (void)transferToRegister{
    /** 初始化 **/
    if (timer) {
        [timer invalidate];
    }
    self.verBtn.enabled = YES;
    remainTime = 60;
    ////
    self.inviteCodeTextField.hidden = NO;
    self.inviteUnderLine.hidden = NO;
    NSMutableAttributedString  *attriText = [[NSMutableAttributedString alloc] initWithString:@"已经有账号，点击登录"];
    [attriText addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(133, 133, 133) range:NSMakeRange(0,8)];
    [attriText addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(255, 52, 58) range:NSMakeRange(8,2)];
    [attriText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 10)];
    [attriText yy_setTextHighlightRange:NSMakeRange(8, 2)
                                  color:RGBCOLOR(255, 52, 58)
                        backgroundColor:[UIColor clearColor]
                              tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        /** 点击事件 **/
      if (self.loginType == YES) {
          [self transferToRegister];
      }else{
          [self transferToLogin];
      }
      self.loginType = !self.loginType;
    }];
    self.transferLabel.attributedText = attriText;
    self.transferLabel.textAlignment = NSTextAlignmentCenter;
    [self.enterBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginType = YES;
    // Do any additional setup after loading the view.
    [self initTheView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard event
- (void)keyboardWillShow:(NSNotification *)sender{
    CGRect keyboardBounds;
    [[sender.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    self.view.frame = CGRectMake(0, -keyboardBounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)keyboardWillHide:(NSNotification *)sender{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.veriCodeTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.inviteCodeTextField resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
