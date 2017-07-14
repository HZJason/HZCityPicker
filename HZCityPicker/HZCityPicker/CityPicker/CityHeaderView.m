//
//  CityHeaderView.m
//  HZCityPicker
//
//  Created by 黄泽 on 2017/7/13.
//  Copyright © 2017年 黄泽. All rights reserved.
//

#import "CityHeaderView.h"

@interface CityHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CityHeaderView

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height)];
}

#pragma mark - Setter
- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:title];
}

#pragma mark - Getter
- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    }
    return _titleLabel;
}


@end
