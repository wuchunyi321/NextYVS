//
//  LinvingInfoViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/9.
//  Copyright © 2019 cy. All rights reserved.
//

#import "LinvingInfoViewController.h"

#import "JWPlayer.h"
#import "CommentCell.h"

#import "LivingModel.h"
#import "CommentModel.h"

@interface LinvingInfoViewController ()
<UITextFieldDelegate,
UITableViewDelegate,
UITableViewDataSource,
JWPlayerDelegate>{
    UIView *commentBgView; //放评论的地方
    UITextField *commentField;//写评论的地方
    UIButton    *postBtn; //提交按钮
    NSInteger pageIndex;  //当前页数
    
    UIButton *backBtn; //返回按钮
}

@property (nonatomic,strong)JWPlayer*player;
@property (nonatomic,strong)NSString *l_id;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView    *tableView;
@property (nonatomic,strong)UIView        *headerView;

@property (nonatomic,strong)UILabel *introductionLabel;

@property (nonatomic,strong)UIView       *topView;
@property (nonatomic,strong)UIButton     *commentBtn;
@property (nonatomic,strong)UIButton     *introduceBtn;

@end
@implementation LinvingInfoViewController

- (UILabel *)introductionLabel{
    if (!_introductionLabel) {
        _introductionLabel = [UILabel new];
        _introductionLabel.numberOfLines = 0;
        _introductionLabel.textColor = RGBCOLOR(34, 34, 34);
        _introductionLabel.textAlignment = NSTextAlignmentLeft;
        _introductionLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:15];
        _introductionLabel.hidden = YES;
    }
    return _introductionLabel;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
    }
    return _topView;
}

- (void)handleCommentClick:(UIButton *)sender{
    if (sender.selected) {
        return;
    }else{
        self.commentBtn.selected = YES;
        self.introduceBtn.selected = NO;
        commentBgView.hidden = NO;
        self.tableView.hidden = NO;
        
        self.introductionLabel.hidden = YES;
    }
}

- (UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn addTarget:self action:@selector(handleCommentClick:) forControlEvents:UIControlEventTouchUpInside];
        [_commentBtn setTitle:@"留言" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:RGBCOLOR(255, 52, 58) forState:UIControlStateSelected];
        [_commentBtn setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
        [_commentBtn.titleLabel setFont:[UserContext getTheFontWithName:@"PingFang-SC-Regular" size:16]];
        _commentBtn.selected = YES;
    }
    return _commentBtn;
}

- (void)handleIntroduceClick:(UIButton *)sender{
    if (sender.selected) {
        return;
    }else{
        self.commentBtn.selected = NO;
        self.introduceBtn.selected = YES;
        
        commentBgView.hidden = YES;
        self.tableView.hidden = YES;
        
        self.introductionLabel.hidden = NO;
    }
}

- (UIButton *)introduceBtn{
    if (!_introduceBtn) {
        _introduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_introduceBtn addTarget:self action:@selector(handleIntroduceClick:) forControlEvents:UIControlEventTouchUpInside];
        [_introduceBtn setTitle:@"简介" forState:UIControlStateNormal];
        [_introduceBtn setTitleColor:RGBCOLOR(255, 52, 58) forState:UIControlStateSelected];
        [_introduceBtn setTitleColor:RGBCOLOR(34, 34, 34) forState:UIControlStateNormal];
        [_introduceBtn.titleLabel setFont:[UserContext getTheFontWithName:@"PingFang-SC-Regular" size:16]];
        _introduceBtn.selected = NO;
    }
    return _introduceBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (JWPlayer *)player{
    if (!_player) {
        _player=[[JWPlayer alloc]initWithFrame:CGRectMake(0, TopStatus, SCREEN_WIDTH,200)];
        _player.delegate = self;
    }
    return _player;
}

- (void)playerTransfer:(JWPlayer *)player withIsLandscape:(NSNumber *)landscape{
    BOOL isLandS = landscape.boolValue;
    if (isLandS) { //横屏
        backBtn.hidden = YES;
        commentBgView.hidden = YES;
    }else{
        backBtn.hidden = NO;
        if (_commentBtn.selected) {
            commentBgView.hidden = NO;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.yunvision.Rotation" object:[NSNumber numberWithBool:YES]];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)initTheView{
    [self.view addSubview:self.player];
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.player.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    UIView *seperateView = [UIView new];
    [self.topView addSubview:seperateView];
    seperateView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.topView);
        make.height.mas_equalTo(10);
    }];
    
    [self.topView addSubview:self.commentBtn];
    [self.topView addSubview:self.introduceBtn];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.topView);
        make.bottom.equalTo(seperateView.mas_top);
        make.right.equalTo(self.introduceBtn.mas_left);
        make.width.mas_equalTo(self.introduceBtn);
    }];
    
    [self.introduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.topView);
        make.bottom.equalTo(seperateView.mas_top);
        make.left.equalTo(self.commentBtn.mas_right);
        make.width.mas_equalTo(self.commentBtn);
    }];
    
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setImage:[UIImage imageNamed:@"BRSource.bundle/nav_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(TopStatus);
        make.left.equalTo(self.view).offset(5);
        make.height.width.mas_equalTo(44);
    }];
    
    /**
     评论区
     */
    commentBgView = [UIView new];
    commentBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:commentBgView];
    commentBgView.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    UIView *upLine = [UIView new];
    upLine.backgroundColor = UIColorFromRGB(0xeeeeee);
    [commentBgView addSubview:upLine];
    
    [upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self->commentBgView);
        make.height.mas_equalTo(0.5);
    }];
    
    commentField = [[UITextField alloc] init];
    commentField.delegate = self;
    commentField.backgroundColor = RGBCOLOR(222, 222, 222);
    commentField.layer.cornerRadius = 18;
    commentField.layer.masksToBounds = YES;
    commentField.placeholder = @"请输入您想说的";
    [commentBgView addSubview:commentField];
    
    [commentField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->commentBgView).offset(13);
        make.centerY.equalTo(self->commentBgView);
        make.height.mas_equalTo(36);
        make.right.equalTo(self->commentBgView).offset(-80);
    }];
    
    postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [postBtn addTarget:self action:@selector(handlePost) forControlEvents:UIControlEventTouchUpInside];
    [postBtn setTitle:@"发送" forState:UIControlStateNormal];
    [postBtn setTitleColor:RGBCOLOR(255, 52, 58) forState:UIControlStateNormal];
    postBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Bold" size:13];
    [commentBgView addSubview:postBtn];
    
    [postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self->commentBgView);
        make.right.equalTo(self->commentBgView).offset(-13);
        make.height.mas_equalTo(36);
        make.left.equalTo(self->commentField.mas_right).offset(5);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self->commentBgView.mas_top);
    }];
    [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    /**
     简介区
     */
    [self.view addSubview:self.introductionLabel];
    LivingModel *item = self.items.firstObject;
    self.introductionLabel.text = item.introduction;
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

- (void)loadNewData{
    pageIndex = 1;
    [self initTheData];
}

- (void)loadMoreData{
    pageIndex ++;
    [self initTheData];
}

- (void)handlePost{
    if ([commentField.text.trime isEqualToString:@""]) {
        JK_HUD_NO(@"您没有发表任何意见哦");
        return;
    }
    
    [JKRequest requestCommentAddWithContent:commentField.text.trime
                                 materialId:self.l_id
                                    success:^(id responseObject) {
        JK_HUD_YES(@"发送成功");
                                        self->commentField.text = @"";
                                        [self loadNewData];
    }
                                    failure:^(NSString *errorMessage,id responseObject) {
        JK_HUD_NO(errorMessage);
    }];
}

- (void)back:(id)sender{
    //这个地方要处理一下，如果视频准备播放，就停止
    if (self.player.isLandscape) { //横屏

    }else{
        [self.player pause];
        self.player = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dealloc{
    self.player = nil;
}

- (void)initTheData{
    [JKRequest requestCommentListWithPageIndex:[NSString stringWithFormat:@"%ld",(long)pageIndex]
                                      pageSize:@"20"
                                    materialId:self.l_id
                                       success:^(id responseObject) {
                                           NSArray *array = [JKModelConvert dataModelWithClass:[CommentModel class] andSource:responseObject[@"list"]];
                                           if (self->pageIndex == 1) {
                                               [self.dataArray removeAllObjects];
                                           }
                                           [self.dataArray addObjectsFromArray:[JKModelConvert dataModelWithClass:[CommentModel class] andSource:array]];
                                           [self.tableView reloadData];
                                           if (array.count == 20){
                                               self.tableView.mj_footer.hidden = NO;
                                           }else{
                                               self.tableView.mj_footer.hidden = YES;
                                           }
                                           [self.tableView.mj_header endRefreshing];
                                           [self.tableView.mj_footer endRefreshing];
                                           
    }
                                       failure:^(NSString *errorMessage,id responseObject) {
                                           JK_HUD_NO(errorMessage);
                                           [self.tableView.mj_header endRefreshing];
                                           [self.tableView.mj_footer endRefreshing];
    }];
}

//界面方向改变的处理
- (void)position: (NSNotification *)notification{
    [self.player rotationChanged:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(position:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    pageIndex = 1;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    // Do any additional setup after loading the view.
    [self initTheView];
    LivingModel *item = self.items.firstObject;
    self.l_id = item.l_id;
    [self.player updatePlayerWith:[NSURL URLWithString:item.videoUrl]];
}

#pragma mark - 键盘弹出的处理事件
- (void)keyboardWillShow:(NSNotification *)sender{
    CGRect keyboardBounds;
    [[sender.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    CGRect  bgViewFrame = commentBgView.frame;
    bgViewFrame.origin.y = CGRectGetHeight(self.view.bounds)-50-keyboardBounds.size.height;
    commentBgView.frame = bgViewFrame;
}

- (void)keyboardWillHide:(NSNotification *)sender{
    CGRect keyboardBounds;
    [[sender.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    CGRect  bgViewFrame = commentBgView.frame;
    bgViewFrame.origin.y = CGRectGetHeight(self.view.bounds)-50;
    if (iPhoneX) {
        bgViewFrame.origin.y = CGRectGetHeight(self.view.bounds)-50-34;
    }
    commentBgView.frame = bgViewFrame;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     [commentField resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark ---- UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *item = [self.dataArray objectAtIndex:indexPath.row];
    NSString *content = [NSString stringWithFormat:@"%@:%@",item.nickname,item.content];
    CGFloat height = [UserContext getTheHeightOfStr:content withWidth:SCREEN_WIDTH-26 AndFont:15];
    return height+16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentModel *item = [self.dataArray objectAtIndex:indexPath.row];
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    [cell loadTheCellWith:item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return;
}

@end
