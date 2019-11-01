//
//  BRTabBarItem.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/29.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRTabBarItem.h"

@implementation BRTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        int iconHeight = 22;
        int iconWidth  = 22;
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-iconWidth)/2, 5, iconWidth, iconHeight)];
        self.iconView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.iconView];
        
        self.textView = [[UILabel alloc]initWithFrame:CGRectMake(0, iconHeight+5, frame.size.width, 17)];
        self.textView.textAlignment = NSTextAlignmentCenter;
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.textColor = UIColorFromRGB(0x999999);
        self.textView.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.textView];
    }
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
