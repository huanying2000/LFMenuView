//
//  LFMenuItem.m
//  LFMenuView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "LFMenuItem.h"


@interface LFMenuItem ()

@property (nonatomic, strong) UIImageView *iconImage; // 图标icon
@property (nonatomic, strong) UILabel *titleLab; // title
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *title;

@end

@implementation LFMenuItem

- (instancetype) initWithIconName:(NSString *)iconName title:(NSString *)title {
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _iconName = iconName;
        _title = title;
    }
    
    return self;
}

- (void)setUpViewsWithRect:(CGRect)rect {
    self.frame = rect;
    CGFloat kItemHeight = self.bounds.size.height;
    CGFloat iconHeight = kItemHeight / 3;
    [self addSubview:self.iconImage];
    [self addSubview:self.titleLab];
    self.iconImage.frame = CGRectMake(iconHeight, iconHeight, iconHeight, iconHeight);
    CGFloat iconMaxY = CGRectGetMaxY(self.iconImage.frame);
    self.titleLab.frame = CGRectMake(iconMaxY + (iconHeight * 3 / 4), iconHeight, iconHeight * 3, iconHeight);
}


- (UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_iconName]];
    }
    return _iconImage;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.text = _title;
        _titleLab.font = [UIFont systemFontOfSize:16.0];
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}


@end
