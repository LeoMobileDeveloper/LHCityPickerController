//
//  LHCityPickerController.h
//  LHCityPickerController
//
//  Created by huangwenchen on 16/3/1.
//  Copyright © 2016年 WenchenHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHCityPickerController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


@property (copy,nonatomic)void(^selectedAction)(NSString * city,LHCityPickerController * picker);
/**
 *  获取上一个访问的城市
 *
 *  @return 上一个城市
 */
+(NSString *)lastVisitCity;

@property (strong,nonatomic)UITableView * tableView;

@property (strong,nonatomic)UISearchBar * searchBar;

@property (strong,nonatomic)UITableView * searchResultTableView;

@end
