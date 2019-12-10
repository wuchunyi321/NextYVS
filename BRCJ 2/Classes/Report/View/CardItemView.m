//
//  CardItemView.m
//  BRCJ
//
//  Created by wuchunyi on 2019/7/31.
//  Copyright © 2019 cy. All rights reserved.
//

#import "CardItemView.h"
#import "ReportPersonModel.h"

@interface CardItemView()

@property (nonatomic,strong)UIImageView *avatar;
@property (nonatomic,strong)UILabel     *nameLabel;
@property (nonatomic,strong)UILabel     *desLabel;

@end

@implementation CardItemView

- (UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BRSource.bundle/report_avatar_default"]];
    }
    return _avatar;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = RGBCOLOR(34, 34, 34);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    }
    return _nameLabel;
}

- (UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.textColor = RGBCOLOR(126, 126, 126);
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:10];
        _desLabel.numberOfLines = 2;
    }
    return _desLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.avatar];
        self.avatar.frame = CGRectMake((frame.size.width-53)/2, 12, 53, 53);
        
        [self addSubview:self.nameLabel];
        self.nameLabel.frame = CGRectMake(0, 12+53+12, frame.size.width, 14);
        
        [self addSubview:self.desLabel];
        self.desLabel.frame = CGRectMake(0, 12+53+12+14+5, frame.size.width, 30);
    }
    return self;
}

- (void)loadTheViewWith:(ReportPersonModel *)item{
    //heat这个字段不对
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:item.headPortrait] placeholderImage:[UIImage imageNamed:@"BRSource.bundle/report_avatar_default"]];
    self.nameLabel.text = item.name;
    self.desLabel.text = item.oneIntroduction;
}

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
