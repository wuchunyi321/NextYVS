//
//  BRTabBarViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRTabBarViewController.h"

#import "BRTabBarItem.h"
#import "BRNavigationController.h"
#import "LivingViewController.h"
#import "ReportViewController.h"
#import "SchoolHomeViewController.h"
#import "StockViewController.h"
#import "MineViewController.h"

@interface BRTabBarViewController ()<UITabBarControllerDelegate>

/** 当前显示的导航**/
@property (nonatomic,strong)BRNavigationController  *currentNav;

/** 直播（成员）模块 **/
@property (nonatomic,strong)BRNavigationController *livingNav;
@property (nonatomic,strong)BRTabBarItem* livingItem;
/** 研报模块（非没有此模块） **/
@property (nonatomic,strong)BRNavigationController *reportNav;
@property (nonatomic,strong)BRTabBarItem* reportItem;
/** 学堂模块 **/
@property (nonatomic,strong)BRNavigationController *schoolNav;
@property (nonatomic,strong)BRTabBarItem* schoolItem;
/** gupiao模块 **/
@property (nonatomic,strong)BRNavigationController *stockNav;
@property (nonatomic,strong)BRTabBarItem *stockItem;
/** 我的模块 **/
@property (nonatomic,strong)BRNavigationController *mineNav;
@property (nonatomic,strong)BRTabBarItem *mineItem;

@end

@implementation BRTabBarViewController

/** 加载的界面**/
- (void)initTheMember{
    NSMutableArray *viewControllers = [NSMutableArray new];
    
    LivingViewController *livingVC =[[LivingViewController alloc] init];
    livingVC.title = @"成员";
    BRNavigationController *livingNav = [[BRNavigationController alloc] initWithRootViewController:livingVC];
    self.livingNav = livingNav;
    [viewControllers addObject:livingNav];
    
    ReportViewController *reportVC =[[ReportViewController alloc] init];
    reportVC.title = @"研报";
    BRNavigationController *reportNav = [[BRNavigationController alloc] initWithRootViewController:reportVC];
    self.reportNav = reportNav;
    [viewControllers addObject:reportNav];
    
    SchoolHomeViewController *schoolVC =[[SchoolHomeViewController alloc] init];
    schoolVC.title = @"学堂";
    BRNavigationController *schoolNav = [[BRNavigationController alloc] initWithRootViewController:schoolVC];
    self.schoolNav = schoolNav;
    [viewControllers addObject:schoolNav];
    
    StockViewController *stockVC =[[StockViewController alloc] init];
    stockVC.title = @"信息";
    BRNavigationController *stockNav = [[BRNavigationController alloc] initWithRootViewController:stockVC];
    self.stockNav = stockNav;
    [viewControllers addObject:stockNav];
    
    MineViewController *mineVC =[[MineViewController alloc] init];
    mineVC.title = @"我的";
    BRNavigationController *mineNav = [[BRNavigationController alloc] initWithRootViewController:mineVC];
    self.mineNav = mineNav;
    [viewControllers addObject:mineNav];
    
    self.viewControllers = viewControllers;
    
    CGFloat bottomHeight = 49;
    if (iPhoneX || iPhoneXR) {
        bottomHeight = 88;
    }
    
    CGFloat width = SCREEN_WIDTH/5;
    
    self.livingItem = [[BRTabBarItem alloc]initWithFrame:CGRectMake(0, 0, width, bottomHeight)];
    self.livingItem.iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.livingItem.textView.text = @"成员";
    [self.tabBar addSubview:self.livingItem];
    
    self.reportItem = [[BRTabBarItem alloc]initWithFrame:CGRectMake(width, 0, width, bottomHeight)];
    self.reportItem.iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.reportItem.textView.text = @"研报";
    [self.tabBar addSubview:self.reportItem];
    
    self.schoolItem = [[BRTabBarItem alloc]initWithFrame:CGRectMake(width*2, 0, width, bottomHeight)];
    self.schoolItem.iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.schoolItem.textView.text = @"学堂";
    [self.tabBar addSubview:self.schoolItem];
    
    self.stockItem = [[BRTabBarItem alloc]initWithFrame:CGRectMake(width*3, 0, width, bottomHeight)];
    self.stockItem.iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.stockItem.textView.text = @"信息";
    [self.tabBar addSubview:self.stockItem];
    
    self.mineItem = [[BRTabBarItem alloc]initWithFrame:CGRectMake(width*4, 0, width, bottomHeight)];
    self.mineItem.iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.mineItem.textView.text = @"我的";
    [self.tabBar addSubview:self.mineItem];
    
    if (self.currentNav == nil) {
        self.currentNav = self.livingNav;
    }
    [self setSelectedViewController:self.livingNav];
    [self setNoMemberItemImages];
}
/** 加载非的界面**/
//- (void)initTheNoMember{
//    NSMutableArray *viewControllers = [NSMutableArray new];
//
//    LivingViewController *livingVC =[[LivingViewController alloc] init];
//    livingVC.title = @"成员";
//    BRNavigationController *livingNav = [[BRNavigationController alloc] initWithRootViewController:livingVC];
//    self.livingNav = livingNav;
//    [viewControllers addObject:livingNav];
//
//    SchoolViewController *schoolVC =[[SchoolViewController alloc] init];
//    schoolVC.title = @"学堂";
//    BRNavigationController *schoolNav = [[BRNavigationController alloc] initWithRootViewController:schoolVC];
//    self.schoolNav = schoolNav;
//    [viewControllers addObject:schoolNav];
//
//
//    MineViewController *mineVC =[[MineViewController alloc] init];
//    mineVC.title = @"我的";
//    BRNavigationController *mineNav = [[BRNavigationController alloc] initWithRootViewController:mineVC];
//    self.mineNav = mineNav;
//    [viewControllers addObject:mineNav];
//
//    self.viewControllers = viewControllers;
//
//    CGFloat width = SCREEN_WIDTH/4;
//
//    self.livingItem = [[BRTabBarItem alloc]initWithFrame:CGRectMake(0, 0, width, 49)];
//    self.livingItem.iconView.contentMode = UIViewContentModeScaleAspectFit;
//    self.livingItem.textView.text = @"成员";
//    [self.tabBar addSubview:self.livingItem];
//
//    self.schoolItem = [[BRTabBarItem alloc]initWithFrame:CGRectMake(width*1, 0, width, 49)];
//    self.schoolItem.iconView.contentMode = UIViewContentModeScaleAspectFit;
//    self.schoolItem.textView.text = @"学堂";
//    [self.tabBar addSubview:self.schoolItem];
//
//
//    self.mineItem = [[BRTabBarItem alloc]initWithFrame:CGRectMake(width*3, 0, width, 49)];
//    self.mineItem.iconView.contentMode = UIViewContentModeScaleAspectFit;
//    self.mineItem.textView.text = @"我的";
//    [self.tabBar addSubview:self.mineItem];
//    if (self.currentNav == nil) {
//        self.currentNav = self.livingNav;
//    }
//    [self setSelectedViewController:self.livingNav];
//    [self setNoMemberItemImages];
//}

- (void)setNoMemberItemImages{
    self.livingItem.iconView.image = [UIImage imageNamed:@"home_living"];
    self.reportItem.iconView.image = [UIImage imageNamed:@"home_report"];
    self.schoolItem.iconView.image = [UIImage imageNamed:@"home_school"];
    self.stockItem.iconView.image = [UIImage imageNamed:@"home_stock"];
    self.mineItem.iconView.image = [UIImage imageNamed:@"home_mine"];
    
    self.livingItem.textView.textColor = RGBCOLOR(110, 110, 100);
    self.reportItem.textView.textColor = RGBCOLOR(110, 110, 100);
    self.schoolItem.textView.textColor = RGBCOLOR(110, 110, 100);
    self.stockItem.textView.textColor = RGBCOLOR(110, 110, 100);
    self.mineItem.textView.textColor = RGBCOLOR(110, 110, 100);
    
    if (self.currentNav == self.livingNav){
        self.livingItem.iconView.image = [UIImage imageNamed:@"home_living_selected"];
        self.livingItem.textView.textColor = RGBCOLOR(255, 52, 58);
    }else if (self.currentNav == self.reportNav){
        self.reportItem.iconView.image = [UIImage imageNamed:@"home_report_selected"];
        self.reportItem.textView.textColor = RGBCOLOR(255, 52, 58);
    }else if (self.currentNav == self.schoolNav){
        self.schoolItem.iconView.image = [UIImage imageNamed:@"home_school_selected"];
        self.schoolItem.textView.textColor = RGBCOLOR(255, 52, 58);
    }else if (self.currentNav == self.stockNav){
        self.stockItem.iconView.image = [UIImage imageNamed:@"home_stock_selected"];
        self.stockItem.textView.textColor = RGBCOLOR(255, 52, 58);
    }else if (self.currentNav == self.mineNav){
        self.mineItem.iconView.image = [UIImage imageNamed:@"home_mine_selected"];
        self.mineItem.textView.textColor = RGBCOLOR(255, 52, 58);
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (viewController == self.livingNav) {
        self.currentNav = self.livingNav;
    }else if (viewController == self.schoolNav){
        self.currentNav = self.schoolNav;
    }else if (viewController == self.stockNav){
        self.currentNav = self.stockNav;
    }else if (viewController == self.mineNav){
        self.currentNav = self.mineNav;
    }else if (viewController == self.reportNav){
        self.currentNav = self.reportNav;
    }
    [self setNoMemberItemImages];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
    [self initTheMember];
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
