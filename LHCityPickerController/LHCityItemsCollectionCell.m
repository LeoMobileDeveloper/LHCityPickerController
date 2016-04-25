//
//  LHCityItemsCollectionCell.m
//  LHCityPickerController
//
//  Created by huangwenchen on 16/3/1.
//  Copyright © 2016年 WenchenHuang. All rights reserved.
//

#import "LHCityItemsCollectionCell.h"

@implementation LHCityItemsCollectionCell
-(instancetype)init{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}
@end
