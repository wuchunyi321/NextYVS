//
//  BRBaseViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/29.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRBaseViewController.h"

#import "AppDelegate.h"

@interface BRBaseViewController ()

@end

@implementation BRBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xf3f4f4);
    [self setBackButton];
}


#pragma mark - custom methods
- (void)setBackButton {
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
}

- (void)hideBackButton {
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    NSLog(@"%@dealloc",self.description);
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
