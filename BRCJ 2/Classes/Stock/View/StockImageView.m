//
//  StockImageView.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "StockImageView.h"

@implementation StockImageView


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_delegate && [_delegate respondsToSelector:@selector(viewClicked:)]){
        [_delegate performSelector:@selector(viewClicked:) withObject:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
