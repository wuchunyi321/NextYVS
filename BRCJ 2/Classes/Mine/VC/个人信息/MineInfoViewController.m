//
//  MineInfoViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import "MineInfoViewController.h"

#import "MineInfoNormalCell.h"
#import "MineMoneyViewController.h"
@interface MineInfoViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UIActionSheetDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MineInfoViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[MineInfoNormalCell class] forCellReuseIdentifier:@"MineInfoNormalCell"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 75;
    }else
        return 44;
}

- (MineInfoNormalCellType )getTheTypeWith:(NSIndexPath *)indexPath{
    MineInfoNormalCellType type = MineInfoNormalCellTypeAvatar;
    if (indexPath.section != 0) {
        if (indexPath.row == 0) {
            type = MineInfoNormalCellTypeNickName;
        }else if (indexPath.row == 1){
            type = MineInfoNormalCellTypeName;
        }else if (indexPath.row == 2){
            type = MineInfoNormalCellTypeSex;
        }else if(indexPath.row == 3){
            type = MineInfoNormalCellTypePhone;
        }else{
            type = MineInfoNormalCellTypeMoney;
        }
    }
    return type;
}

- (NSString *)getTheValueWith:(NSIndexPath *)indexPath{
    UserInfoModel *user = [UserInfoModel readFromFile];
    NSString *backStr = @"";
    if (indexPath.section != 0) {
        if (indexPath.row == 0) {
            backStr = user.nickname;
        }else if (indexPath.row == 1){
            backStr = user.name;
        }else if (indexPath.row == 2){
            backStr = user.sex?(user.sex.intValue == 1?@"男":@"女"):@"";
        }else if(indexPath.row == 3){
            backStr = user.mobile;
        }
    }else{
        backStr = user.headPortrait;
    }
    return backStr;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineInfoNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineInfoNormalCell"];
    [cell loadTheCellWithType:[self getTheTypeWith:indexPath] value:[self getTheValueWith:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIActionSheet  *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"相册",@"拍照", nil];
        sheet.tag = 888;
        [sheet showInView:self.view];
    }else{
         UserInfoModel *user = [UserInfoModel readFromFile];
        if (indexPath.row == 0) { //昵称
            __weak typeof(self) weakSelf = self;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField*userNameTextField = alertController.textFields.firstObject;
                [JKRequest requestUserInfoUpdate:userNameTextField.text
                                             sex:@""
                                            name:@""
                                    headPortrait:@""
                                              id:user.user_id
                                         success:^(id responseObject) {
                                             UserInfoModel *user = [JKModelConvert dataModelWithClass:[UserInfoModel class] andSource:responseObject[@"data"]];
                                             [user saveToFile];
                                             [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                    //上一页也需要刷新
                    if (_delegate && [_delegate respondsToSelector:@selector(updateMyInfo)]) {
                        [_delegate performSelector:@selector(updateMyInfo)];
                    }
                                         } failure:^(NSString *errorMessage, id responseObject) {
                                             JK_HUD_NO(errorMessage);
                                         }];
                
            }]];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
                textField.placeholder=@"请输入昵称";
                textField.text = user.nickname;
            }];
            [self presentViewController:alertController animated:YES completion:nil];
        }else if(indexPath.row == 1){ //姓名
            __weak typeof(self) weakSelf = self;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入姓名" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UITextField*userNameTextField = alertController.textFields.firstObject;
                [JKRequest requestUserInfoUpdate:@""
                                             sex:@""
                                            name:userNameTextField.text
                                    headPortrait:@""
                                              id:user.user_id
                                         success:^(id responseObject) {
                                             UserInfoModel *user = [JKModelConvert dataModelWithClass:[UserInfoModel class] andSource:responseObject[@"data"]];
                                             [user saveToFile];
                                             [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                                         } failure:^(NSString *errorMessage, id responseObject) {
                                             JK_HUD_NO(errorMessage);
                                         }];
                
            }]];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
                textField.placeholder=@"请输入姓名";
                textField.text = user.name;
            }];
            [self presentViewController:alertController animated:YES completion:nil];
        }else if(indexPath.row == 2){ //性别
            UIActionSheet  *sheet = [[UIActionSheet alloc] initWithTitle:@"性别"
                                                                delegate:self
                                                       cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                       otherButtonTitles:@"女",@"男", nil];
            sheet.tag = 999;
            [sheet showInView:self.view];
        }else if (indexPath.row == 4){
            MineMoneyViewController *moneyVc = [[MineMoneyViewController alloc] init];
            moneyVc.title = @"提现";
            [self.navigationController pushViewController:moneyVc animated:YES];
        }
    }
}

-(void)addImageWith:(NSData *)image{
    UserInfoModel *user = [UserInfoModel readFromFile];
    [JKRequest requestUploadWithKey:@"head-portrait"
                               data:image
                            success:^(id responseObject) {
                                NSString *avatarUrl = responseObject[@"data"];
                                [JKRequest requestUserInfoUpdate:@""
                                                             sex:@""
                                                            name:@""
                                                    headPortrait:avatarUrl
                                                              id:user.user_id
                                                         success:^(id responseObject) {
                                                             UserInfoModel *user = [JKModelConvert dataModelWithClass:[UserInfoModel class] andSource:responseObject[@"data"]];
                                                             [user saveToFile];
                                                             [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                                    //上一页也要刷新
                                    if (_delegate && [_delegate respondsToSelector:@selector(updateMyInfo)]) {
                                        [_delegate performSelector:@selector(updateMyInfo)];
                                    }
                                                         } failure:^(NSString *errorMessage, id responseObject) {
                                                             JK_HUD_NO(errorMessage);
                                                         }];
                            }
                            failure:^(NSString *errorMessage, id responseObject) {
                                JK_HUD_NO(errorMessage);
                            }];
}

#pragma mark -- UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSData *postImage = UIImageJPEGRepresentation(image, 0.5);
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf addImageWith:postImage];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0: //相册
        {
            if (actionSheet.tag == 888) {
                if ([BRTool permissionAboutPhoto]) {
                    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
                    ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                    ipc.delegate = self;
                    ipc.allowsEditing = YES;
                    [self presentViewController:ipc animated:YES completion:nil];
                }
            }else{
                UserInfoModel *user = [UserInfoModel readFromFile];
                [JKRequest requestUserInfoUpdate:@""
                                             sex:[NSString stringWithFormat:@"%ld",(long)buttonIndex]
                                            name:@""
                                    headPortrait:@""
                                              id:user.user_id
                                         success:^(id responseObject) {
                                             UserInfoModel *user = [JKModelConvert dataModelWithClass:[UserInfoModel class] andSource:responseObject[@"data"]];
                                             [user saveToFile];
                                             [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                                         } failure:^(NSString *errorMessage, id responseObject) {
                                             JK_HUD_NO(errorMessage);
                                         }];
            }
        }
            break;
        case 1://照相
        {
            if (actionSheet.tag == 888) {
                if ([BRTool permissionAboutCamera]) {
                    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
                    ipc.sourceType =  UIImagePickerControllerSourceTypeCamera;
                    ipc.delegate = self;
                    ipc.allowsEditing = YES;
                    [self presentViewController:ipc animated:YES completion:nil];
                }
            }else{
                UserInfoModel *user = [UserInfoModel readFromFile];
                [JKRequest requestUserInfoUpdate:@""
                                             sex:[NSString stringWithFormat:@"%ld",(long)buttonIndex]
                                            name:@""
                                    headPortrait:@""
                                              id:user.user_id
                                         success:^(id responseObject) {
                                             UserInfoModel *user = [JKModelConvert dataModelWithClass:[UserInfoModel class] andSource:responseObject[@"data"]];
                                             [user saveToFile];
                                             [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                                         } failure:^(NSString *errorMessage, id responseObject) {
                                             JK_HUD_NO(errorMessage);
                                         }];
            }
        }
            break;
        default:
            break;
    }
}


@end
