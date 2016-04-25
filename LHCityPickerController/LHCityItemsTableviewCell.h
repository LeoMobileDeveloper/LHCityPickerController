//
//  LHCityItemsCell.h
//  LHCityPickerController
//
//  Created by huangwenchen on 16/3/1.
//  Copyright © 2016年 WenchenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LHCity;
@interface LHCityItemsTableviewCell : UITableViewCell

@property (strong,nonatomic)NSArray<LHCity *> * citys;

@property (copy,nonatomic)void(^clickAction)(NSInteger index);

@end
