//
//  LHCityItemsCell.m
//  LHCityPickerController
//
//  Created by huangwenchen on 16/3/1.
//  Copyright © 2016年 WenchenHuang. All rights reserved.
//

#import "LHCityItemsTableviewCell.h"
#import "LHCityItemsCollectionCell.h"
#import "LHCity.h"
#import "UIColor+LHCityPickerHelper.h"

@interface LHCityItemsTableviewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong,nonatomic)UICollectionView * collectionview;

@end
@implementation LHCityItemsTableviewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize  = CGSizeMake(80,30);
    flowLayout.minimumInteritemSpacing = 3.0;
    flowLayout.minimumLineSpacing = 10.0;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.collectionview.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    self.collectionview.scrollEnabled = NO;
    [self.contentView addSubview:self.collectionview];
    self.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    self.collectionview.collectionViewLayout = flowLayout;
    [self.collectionview registerClass:[LHCityItemsCollectionCell class] forCellWithReuseIdentifier:@"cell"];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionview.frame = CGRectMake(8,0, self.contentView.frame.size.width - 8 - 16, self.contentView.frame.size.height);
}
-(void)setCitys:(NSArray<LHCity *> *)citys{
    _citys = citys;
    [self.collectionview reloadData];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.citys.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.clickAction) {
        self.clickAction(indexPath.row);
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHCityItemsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    LHCity * city = [self.citys objectAtIndex:indexPath.row];
    cell.titleLabel.text = city.name;
    return cell;
}

@end
