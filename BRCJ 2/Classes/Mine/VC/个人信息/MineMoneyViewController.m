//
//  MineMoneyViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/6.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineMoneyViewController.h"

#import "MineCardListViewController.h"

#import "MineCardImageView.h"

#import "UserFinanceModel.h"
#import "BankCardModel.h"


#define btnSpace (SCREEN_WIDTH-83*3-16*2)/2

@interface MineMoneyViewController ()<MineCardImageViewDelegate>

@property (nonatomic,strong)UILabel  *allMoneyLabel;

@property (nonatomic,strong)UILabel  *getMoneyLabel;

/** 1/3按钮 **/
@property (nonatomic,strong)UIButton *oneThirdBtn;

/** 2/3 按钮 **/
@property (nonatomic,strong)UIButton *twoThirdBtn;

/** 全部取出按钮 **/
@property (nonatomic,strong)UIButton *allBtn;

/** 银行卡片 **/
@property (nonatomic,strong)MineCardImageView *cardImage;

/** 信息  **/
@property (nonatomic,strong)UserFinanceModel *userfinModel;

/** 银行卡 **/
@property (nonatomic,strong)BankCardModel   *cardModel;

@property (nonatomic,assign)NSInteger  postAcount;


@end

@implementation MineMoneyViewController

- (MineCardImageView *)cardImage{
    if (!_cardImage) {
        _cardImage = [[MineCardImageView alloc] initWithImage:[UIImage imageNamed:@"mine_card"]];
        _cardImage.delegate = self;
    }
    return _cardImage;
}

- (UILabel *)allMoneyLabel{
    if (!_allMoneyLabel) {
        _allMoneyLabel = [UILabel new];
        _allMoneyLabel.textAlignment = NSTextAlignmentLeft;
        _allMoneyLabel.textColor = RGBCOLOR(255, 52, 58);
        _allMoneyLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:18];
    }
    return _allMoneyLabel;
}

- (UILabel *)getMoneyLabel{
    if (!_getMoneyLabel) {
        _getMoneyLabel = [UILabel new];
        _getMoneyLabel.textAlignment = NSTextAlignmentLeft;
        _getMoneyLabel.textColor = RGBCOLOR(131, 131, 131);
        _getMoneyLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:18];
        _getMoneyLabel.layer.borderColor = RGBCOLOR(163, 163, 163).CGColor;
        _getMoneyLabel.layer.borderWidth = 0.5;
    }
    return _getMoneyLabel;
}

- (void)handleMoney:(UIButton *)btn{
    switch (btn.tag-999) {
        case 1: // 1/3
        {
            self.oneThirdBtn.selected = YES;
            self.twoThirdBtn.selected = NO;
            self.allBtn.selected = NO;
            self.twoThirdBtn.backgroundColor = [UIColor whiteColor];
            self.oneThirdBtn.backgroundColor = RGBACOLOR(255, 43, 43, 0.2);
            self.allBtn.backgroundColor = [UIColor whiteColor];
            self.postAcount = ceil(self.userfinModel.totalUse.integerValue/3);
        }
            break;
        case 2: // 2/3
        {
            self.oneThirdBtn.selected = NO;
            self.twoThirdBtn.selected = YES;
            self.allBtn.selected = NO;
            self.twoThirdBtn.backgroundColor = RGBACOLOR(255, 43, 43, 0.2);
            self.oneThirdBtn.backgroundColor = [UIColor whiteColor];
            self.allBtn.backgroundColor = [UIColor whiteColor];
            
            self.postAcount = ceil(self.userfinModel.totalUse.integerValue*2/3);
        }
            break;
        case 3:// 全部
        {
            self.oneThirdBtn.selected = NO;
            self.twoThirdBtn.selected = NO;
            self.allBtn.selected = YES;
            self.twoThirdBtn.backgroundColor = [UIColor whiteColor];
            self.oneThirdBtn.backgroundColor = [UIColor whiteColor];
            self.allBtn.backgroundColor = RGBACOLOR(255, 43, 43, 0.2);
            
            self.postAcount = self.userfinModel.totalUse.integerValue;
        }
            break;
        default:
            break;
    }
    self.getMoneyLabel.text = [NSString stringWithFormat:@"%ld",(long)self.postAcount];
}

- (UIButton *)oneThirdBtn{
    if (!_oneThirdBtn) {
        _oneThirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _oneThirdBtn.tag = 999+1;
        [_oneThirdBtn addTarget:self action:@selector(handleMoney:) forControlEvents:UIControlEventTouchUpInside];
        [_oneThirdBtn setTitle:@"1/3" forState:UIControlStateNormal];
        [_oneThirdBtn setTitleColor:RGBCOLOR(255, 52, 58) forState:UIControlStateSelected];
        [_oneThirdBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        _oneThirdBtn.layer.borderWidth = 0.5;
        _oneThirdBtn.layer.borderColor = RGBCOLOR(243, 125, 125).CGColor;
        _oneThirdBtn.layer.shadowColor = RGBCOLOR(243, 125, 125).CGColor;//shadowColor阴影颜色
        _oneThirdBtn.layer.shadowOffset = CGSizeZero;
        _oneThirdBtn.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        _oneThirdBtn.layer.shadowRadius = 3;//阴影半径，默认3
        _oneThirdBtn.backgroundColor = [UIColor whiteColor];
    }
    return _oneThirdBtn;
}

- (UIButton *)twoThirdBtn{
    if (!_twoThirdBtn) {
        _twoThirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _twoThirdBtn.tag = 999+2;
        [_twoThirdBtn addTarget:self action:@selector(handleMoney:) forControlEvents:UIControlEventTouchUpInside];
        [_twoThirdBtn setTitle:@"2/3" forState:UIControlStateNormal];
        [_twoThirdBtn setTitleColor:RGBCOLOR(255, 52, 58) forState:UIControlStateSelected];
        [_twoThirdBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        _twoThirdBtn.layer.borderWidth = 0.5;
        _twoThirdBtn.layer.borderColor = RGBCOLOR(243, 125, 125).CGColor;
        _twoThirdBtn.layer.shadowColor = RGBCOLOR(243, 125, 125).CGColor;//shadowColor阴影颜色
        _twoThirdBtn.layer.shadowOffset = CGSizeZero;
        _twoThirdBtn.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        _twoThirdBtn.layer.shadowRadius = 3;//阴影半径，默认3
        _twoThirdBtn.backgroundColor = [UIColor whiteColor];
    }
    return _twoThirdBtn;
}

- (UIButton *)allBtn{
    if (!_allBtn) {
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allBtn.tag = 999+3;
        [_allBtn addTarget:self action:@selector(handleMoney:) forControlEvents:UIControlEventTouchUpInside];
        [_allBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_allBtn setTitleColor:RGBCOLOR(255, 52, 58) forState:UIControlStateSelected];
        [_allBtn setTitleColor:RGBCOLOR(68, 68, 68) forState:UIControlStateNormal];
        _allBtn.layer.borderWidth = 0.5;
        _allBtn.layer.borderColor = RGBCOLOR(243, 125, 125).CGColor;
        _allBtn.layer.shadowColor = RGBCOLOR(243, 125, 125).CGColor;//shadowColor阴影颜色
        _allBtn.layer.shadowOffset = CGSizeZero;
        _allBtn.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        _allBtn.layer.shadowRadius = 3;//阴影半径，默认3
        _allBtn.backgroundColor = [UIColor whiteColor];
    }
    return _allBtn;
}

- (void)initTheView{
    
    /** 最上面一部分 **/
    UIView *firstPart = [UIView new];
    firstPart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstPart];
    
    [firstPart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.view).mas_equalTo(TopHeight);
    }];
    
    UILabel *allTitleLabel = [UILabel new];
    allTitleLabel.text = @"总金额（元）:";
    allTitleLabel.textColor = RGBCOLOR(68, 68, 68);
    allTitleLabel.textAlignment = NSTextAlignmentLeft;
    allTitleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:15];
    [firstPart addSubview:allTitleLabel];
    
    [allTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(firstPart);
        make.left.equalTo(firstPart).offset(16);
        make.width.mas_equalTo(95);
    }];
    
    [firstPart addSubview:self.allMoneyLabel];
    [self.allMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allTitleLabel.mas_right).offset(5);
        make.centerY.equalTo(firstPart);
        make.width.mas_equalTo(155);
    }];
    
    /** 第二部分 **/
    UIView *secordPart = [UIView new];
    secordPart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secordPart];
    
    [secordPart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(firstPart.mas_bottom).offset(5);
        make.height.mas_equalTo(115);
    }];
    
    UILabel *mountlabel = [UILabel new];
    mountlabel.text = @"提现金额";
    mountlabel.textColor = RGBCOLOR(68, 68, 68);
    mountlabel.textAlignment = NSTextAlignmentLeft;
    mountlabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:15];
    [secordPart addSubview:mountlabel];
    [mountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secordPart).offset(16);
        make.width.mas_equalTo(60);
        make.top.equalTo(secordPart).offset(24);
        make.height.mas_equalTo(14);
    }];
    
    [secordPart addSubview:self.getMoneyLabel];
    [self.getMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mountlabel.mas_right).offset(20);
        make.top.equalTo(secordPart).offset(17);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(25);
    }];
    
    [secordPart addSubview:self.oneThirdBtn];
    [secordPart addSubview:self.twoThirdBtn];
    [secordPart addSubview:self.allBtn];
    
    [self.oneThirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secordPart).offset(16);
        make.top.equalTo(mountlabel.mas_bottom).offset(30);
        make.width.mas_equalTo(83);
        make.height.mas_equalTo(30);
    }];
    
    [self.twoThirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneThirdBtn.mas_right).offset(btnSpace);
        make.top.equalTo(mountlabel.mas_bottom).offset(30);
        make.width.mas_equalTo(83);
        make.height.mas_equalTo(30);
    }];
    
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.twoThirdBtn.mas_right).offset(btnSpace);
        make.top.equalTo(mountlabel.mas_bottom).offset(30);
        make.width.mas_equalTo(83);
        make.height.mas_equalTo(30);
    }];
    
    /** 第三部分 **/
    UIView *thirdPart = [UIView new];
    thirdPart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:thirdPart];
    
    [thirdPart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(secordPart.mas_bottom).offset(5);
        make.height.mas_equalTo(132);
    }];
    
    UILabel *cardTitleLabel = [UILabel new];
    cardTitleLabel.text = @"选择银行卡";
    cardTitleLabel.textColor = RGBCOLOR(68, 68, 68);
    cardTitleLabel.textAlignment = NSTextAlignmentLeft;
    cardTitleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:15];
    [thirdPart addSubview:cardTitleLabel];
    
    [cardTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(thirdPart).offset(16);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(80);
    }];
    
    [thirdPart addSubview:self.cardImage];
    self.cardImage.userInteractionEnabled = YES;
    [self.cardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(thirdPart);
        make.top.equalTo(cardTitleLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(CARDWIDTH);
        make.height.mas_equalTo(CARDHEIGHT);
    }];

    
    /** 提交按钮部分 **/
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [postBtn addTarget:self action:@selector(handlePost) forControlEvents:UIControlEventTouchUpInside];
    postBtn.backgroundColor = RGBCOLOR(255, 52, 58);
    [postBtn setTitle:@"提交" forState:UIControlStateNormal];
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    postBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:15];
    [self.view addSubview:postBtn];
    
    [postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(thirdPart.mas_bottom).offset(44);
        make.height.mas_equalTo(44);
    }];
}

/** 点击了图片**/
- (void)viewClicked:(MineCardImageView *)imageView{
    __weak typeof(self) weakSelf = self;
    MineCardListViewController *cards = [[MineCardListViewController alloc] init];
    cards.title = @"银行卡";
    cards.backData = ^(id data) {
        weakSelf.cardModel = (BankCardModel *)data;
        [weakSelf.cardImage loadTheCellWith:weakSelf.cardModel];
    };
    [self.navigationController pushViewController:cards animated:YES];
}

/** 提交 **/
- (void)handlePost{
    if (!self.cardModel) {
        JK_HUD_NO(@"请添加银行卡信息");
        return;
    }
    
    if (self.postAcount < 500) {
        JK_HUD_NO(@"单次最少提现额度是500元");
        return;
    }
    
    [JKRequest requestMoneyAdd:self.cardModel.card_id
                    drawAmount:[NSString stringWithFormat:@"%ld",(long)self.postAcount]
                       success:^(id responseObject) {
                           [self.navigationController popViewControllerAnimated:YES];
                       }
                       failure:^(NSString *errorMessage,id responseObject) {
                           JK_HUD_NO(errorMessage);
                       }];
}

- (void)loadInfo{
    self.allMoneyLabel.text = self.userfinModel.totalUse;
    [self.cardImage loadTheCellWith:self.cardModel];
}

- (void)initTheData{
    [JKRequest requestMoneyInfoWithSuccess:^(id responseObject) {
        self.userfinModel = [JKModelConvert dataModelWithClass:[UserFinanceModel class] andSource:responseObject[@"userFinance"]];
        self.cardModel = [JKModelConvert dataModelWithClass:[BankCardModel class] andSource:responseObject[@"bankCard"]];
        [self loadInfo];
    } failure:^(NSString *errorMessage,id responseObject) {
        JK_HUD_NO(errorMessage);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTheView];
    [self initTheData];
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
