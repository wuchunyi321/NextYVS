//
//  MineInviteViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineInviteViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>

#define inviteBgWidth        375*mulNumber
#define inviteBgHeight       538*mulNumber
#define erCodeBgWidth        246*mulNumber
#define erCodeBgHeight       318*mulNumber

@interface MineInviteViewController (){
    UIButton *rightBtn;
}
@property (nonatomic,strong)UILabel *ercodeLabel;


@end

@implementation MineInviteViewController

- (UILabel *)ercodeLabel{
    if (!_ercodeLabel) {
        _ercodeLabel = [UILabel new];
        _ercodeLabel.textColor = RGBCOLOR(252, 106, 79);
        _ercodeLabel.textAlignment = NSTextAlignmentCenter;
        _ercodeLabel.font = [UserContext getTheFontWithName:@"AdobeHeitiStd-Regular" size:24];
    }
    return _ercodeLabel;
}

- (void)handleSave{
    if ([BRTool permissionAboutPhoto]) {
        UIGraphicsBeginImageContext(self.view.bounds.size); //currentView当前的view
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        JK_HUD_YES(@"图片保存成功");
    }else{
        JK_HUD_NO(error.description);
    }
}


//生成二维码
//- (UIImage *)generateQRCodeWithString:(NSString *)string Size:(CGFloat)size{
//    //创建过滤器
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    //过滤器恢复默认
//    [filter setDefaults];
//    //给过滤器添加数据<字符串长度893>
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    [filter setValue:data forKey:@"inputMessage"];
//    //获取二维码过滤器生成二维码
//    CIImage *image = [filter outputImage];
//    UIImage *img = [self createNonInterpolatedUIImageFromCIImage:image WithSize:size];
//    return img;
//}

//二维码清晰
//- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image WithSize:(CGFloat)size{
//    CGRect extent = CGRectIntegral(image.extent);
//    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
//    //创建bitmap
//    size_t width = CGRectGetWidth(extent)*scale;
//    size_t height = CGRectGetHeight(extent)*scale;
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//    //保存图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    CGContextRelease(bitmapRef);
//    CGImageRelease(bitmapImage);
//    return [UIImage imageWithCGImage:scaledImage];
//}

- (void)initTheView{
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BRSource.bundle/mine_invite_bg"]];
    [self.view addSubview:bgImage];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(TopHeight);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"推荐好友领福利";
    titleLabel.textColor = RGBCOLOR(255, 52, 58);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Bold" size:24];
    [bgImage addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(TopHeight+10);
        make.height.mas_equalTo(24);
    }];
    
    UIImageView  *ercodeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BRSource.bundle/mine_ercode_bg"]];
    [bgImage addSubview:ercodeImage];
    
    [ercodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(erCodeBgWidth);
        make.height.mas_equalTo(erCodeBgHeight);
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
    }];
    
    /**
     */
    UILabel *inviteTitle = [UILabel new];
    inviteTitle.text = @"邀请码";
    inviteTitle.textColor = RGBCOLOR(51, 51, 51);
    inviteTitle.textAlignment = NSTextAlignmentCenter;
    inviteTitle.font = [UserContext getTheFontWithName:@"PingFang-SC-Light" size:18];
    [ercodeImage addSubview:inviteTitle];
    
    [inviteTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(ercodeImage).offset(13);
        make.height.mas_equalTo(20);
    }];
    
    [ercodeImage addSubview:self.ercodeLabel];
    
    [self.ercodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(inviteTitle.mas_bottom).offset(8);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *detalLabel = [UILabel new];
    detalLabel.text = @"您的好友在注册时可填写邀请码";
    detalLabel.textColor = RGBCOLOR(153, 153, 153);
    detalLabel.textAlignment = NSTextAlignmentCenter;
    detalLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Light" size:12];
    [ercodeImage addSubview:detalLabel];
    
    [detalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.ercodeLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(12);
    }];
    
    UIView *line = [UIView new]; //虚线
    line.backgroundColor = [UIColor blackColor];
    [ercodeImage addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ercodeImage);
        make.left.equalTo(ercodeImage).offset(4);
        make.right.equalTo(ercodeImage).offset(-4);
        make.top.equalTo(detalLabel.mas_bottom).offset(2);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *ercode = [[UIImageView alloc] init];
    ercode.image = [UIImage imageNamed:@"BRSource.bundle/21573208056_.pic_hd.jpg"];
    [ercodeImage addSubview:ercode];
    
    [ercode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ercodeImage);
        make.width.height.mas_equalTo(125);
        make.top.equalTo(line.mas_bottom).offset(20);
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn addTarget:self action:@selector(handleSave) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.backgroundColor = RGBCOLOR(255, 52, 58);
    saveBtn.layer.cornerRadius = 20;
    saveBtn.layer.masksToBounds = YES;
    [saveBtn setTitle:@"保存图片" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:16];
    [self.view addSubview:saveBtn];
    
    CGFloat toBottom = 30;
    if (iPhone5) {
        toBottom = 15;
    }
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.right.equalTo(self.view).offset(-100);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self.view.mas_bottom).offset(-toBottom);
    }];
}

- (void)tapNaviRightButton{
    rightBtn.enabled = NO;
    [JKRequest requestUpdateInviteCodeSuccess:^(id responseObject) {
        NSString *inviteCode = responseObject[@"data"][@"inviteCode"];
        UserInfoModel *user = [UserInfoModel readFromFile];
        user.inviteCode = inviteCode;
        [user saveToFile];
        [self writeInfo];
        self->rightBtn.enabled = YES;
    } failure:^(NSString *errorMessage, id responseObject) {
        JK_HUD_NO(errorMessage);
        self->rightBtn.enabled = YES;
    }];
}

- (void)initTheNav{
    rightBtn = [[UIButton alloc] init];
    [rightBtn addTarget:self action:@selector(tapNaviRightButton) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.enabled = YES;
    [rightBtn setTitle:@"重置" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    rightBtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *RightbarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:RightbarButtonItem];
}

- (void)writeInfo{
    UserInfoModel *user = [UserInfoModel readFromFile];
    self.ercodeLabel.text = user.inviteCode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTheView];
    [self initTheNav];
    [self writeInfo];
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
