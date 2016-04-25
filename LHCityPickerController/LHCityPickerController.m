//
//  LHCityPickerController.m
//  LHCityPickerController
//
//  Created by huangwenchen on 16/3/1.
//  Copyright © 2016年 WenchenHuang. All rights reserved.
//

#import "LHCityPickerController.h"
#import "LHCity.h"
#import "LHCityItemsTableviewCell.h"
#import "UIColor+LHCityPickerHelper.h"
@interface LHCityPickerController()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (strong,nonatomic)NSArray * citysArray;//A-Z对应的City

@property (strong,nonatomic)NSArray * sectionTitlesArray;// A - Z

@property (strong,nonatomic)NSArray * searchResultCitys;

@property (strong,nonatomic)NSArray * visityHistoryArray;

@property (strong,nonatomic)NSArray * allCitys;

@end

@implementation LHCityPickerController

+(NSString *)lastVisitCity{
    NSArray * lastCitys = [LHCityPickerController loadVisitHistory];
    NSString * last = lastCitys.firstObject;
    return last;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    //This prevent view from under nav bar
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40,CGRectGetWidth(self.view.frame), CGRectGetHeight([UIScreen mainScreen].bounds)-40)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.sectionIndexBackgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.5];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadPlistOnlyCitys];
    self.visityHistoryArray =  [LHCityPickerController loadVisitHistory];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.frame), 40)];
//    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.searchBar];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.layer.borderColor = [UIColor colorWithHex:0xf5f5f5].CGColor;
    self.searchBar.placeholder = @"输入城市名称或拼音搜索";
    self.searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40,CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-40)];
    self.searchResultTableView.dataSource = self;
    self.searchResultTableView.delegate = self;
//    self.searchResultTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.searchResultTableView];
    
    self.searchResultTableView.hidden = YES;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    self.searchBar.barTintColor = [UIColor colorWithHex:0xf5f5f5];

//    NSDictionary * viewsDic = NSDictionaryOfVariableBindings(_searchBar,_tableView,_searchResultTableView);
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_searchBar]-0-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:viewsDic]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_searchBar(40)]"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:viewsDic]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:viewsDic]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_searchBar]-0-[_tableView]-0-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:viewsDic]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_searchResultTableView]-0-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:viewsDic]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_searchBar]-0-[_searchResultTableView]-0-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:viewsDic]];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchResultCitys = [LHCity findCityModelWithCityName:@[searchText] cityModels:self.allCitys isFuzzy:YES];
    if (searchText != nil && searchText.length > 0) {
        self.tableView.hidden = YES;
        self.searchResultTableView.hidden = NO;
        self.searchResultTableView.delegate = self;
        [self.searchResultTableView reloadData];
    }else{
        self.tableView.hidden = NO;
        self.searchResultTableView.hidden = YES;
    }
}

+(NSString *)visitHistoryFilePath{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * docURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject.path;
    NSString * cityDir = [docURL stringByAppendingPathComponent:@"LHCityPicker"];
    NSString * fileName = @"LHCityVisitHistory.pist";
    NSString * fullPath = [cityDir stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:fullPath] == false) {
        NSError * error;
        [fileManager createDirectoryAtPath:cityDir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"Create LHCityPicker file fail");
        }
    }
    return fullPath;
}

+(NSArray *)loadVisitHistory{
    NSString * fullPath = [self visitHistoryFilePath];
    NSData * data = [NSData dataWithContentsOfFile:fullPath];
    NSArray * visityHistoryArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return visityHistoryArray;
}
+(void)saveVisityHistory:(NSString *)cityName{
    NSString * fullPath = [self visitHistoryFilePath];
    NSData * data = [NSData dataWithContentsOfFile:fullPath];
    NSArray * lastArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSMutableArray * mutableArray;
    if (lastArray == nil) {
        mutableArray = [NSMutableArray new];
    }else{
        mutableArray = [lastArray mutableCopy];
    }
    if ([mutableArray containsObject:cityName]) {
        [mutableArray removeObject:cityName];
        [mutableArray insertObject:cityName atIndex:0];
    }else if(lastArray.count == 6){
        [mutableArray removeLastObject];
        [mutableArray insertObject:cityName atIndex:0];
    }else{
        [mutableArray insertObject:cityName atIndex:0];
    }
    NSData * currentData = [NSKeyedArchiver archivedDataWithRootObject:mutableArray];
    BOOL success = [currentData writeToFile:fullPath atomically:YES];
    if (success == NO) {
        NSLog(@"LHCityPicker save data fail");
    }
}
-(void)loadPlistOnlyCitys{
    NSURL * fileURL = [[NSBundle mainBundle] URLForResource:@"City" withExtension:@"plist"];
    NSArray * array = [[NSArray alloc] initWithContentsOfURL:fileURL];
    NSMutableArray * allCitys = [NSMutableArray new];
    NSMutableArray * sectionsTitles = [NSMutableArray new];
    NSMutableArray * citysArray = [NSMutableArray new];
    //加载全部城市
    for (NSDictionary * provinceDic in array) {
        NSArray * childrens = [provinceDic objectForKey:@"children"];
        if (childrens != nil) {
            for (NSDictionary * cityDic in childrens) {
                LHCity * city = [LHCity cityWithDictionary:cityDic];
                [allCitys addObject:city];
            }
        }
    }
    self.allCitys = allCitys;
    //过滤到A-Z并且排序
    for (char a = 'A'; a <= 'Z'; a++)
    {
        NSMutableArray * mutableArray = [NSMutableArray new];
        NSString * str = [NSString stringWithFormat:@"%c", a];
        for (LHCity * city in allCitys) {
            if ([[city.firstCharacter uppercaseString] isEqualToString:str]) {
                [mutableArray addObject:city];
            }
        }
        if (mutableArray.count > 0) {
            [mutableArray sortedArrayUsingComparator:^NSComparisonResult(LHCity * obj1,LHCity * obj2) {
                return [obj1.spell compare:obj2.spell];
            }];
            [sectionsTitles addObject:str];
            [citysArray addObject:mutableArray];
        }
    }
    self.sectionTitlesArray = sectionsTitles;
    [sectionsTitles insertObject:@"热门" atIndex:0];
    [sectionsTitles insertObject:@"最近" atIndex:0];
    self.citysArray = citysArray;

}
#pragma mark - Tableviewdatasource and tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.tableView) {
        return self.sectionTitlesArray.count;
    }else{
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        if (section == 0 || section == 1) {
            return 1;
        }else{
            NSArray * citys = [self.citysArray objectAtIndex:section-2];
            return citys.count;
        }
    }else{
        return self.searchResultCitys.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            if (self.visityHistoryArray.count > 3) {
                return 90;
            }else{
                return 45;
            }
        }
        if (indexPath.section == 1) {
            return 90;
        }
        return 44;
    }else{
        return 44.0;
    }

}
-(NSArray *)lhCitysWithName:(NSArray *)names{
    NSMutableArray * mutableArray = [NSMutableArray new];
    for (NSString * name in names) {
        LHCity * city = [[LHCity alloc] init];
        city.name = name;
        [mutableArray addObject:city];
    }
    return mutableArray;
}
-(NSArray *)hotCitysArray{
    NSArray * names = @[@"南京",@"上海",@"常州",@"苏州",@"北京",@"沈阳"];
   return [self lhCitysWithName:names];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        if (indexPath.section == 0 || indexPath.section == 1) {
            NSString *reuseID = @"itemcell";
            LHCityItemsTableviewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            cell.contentView.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
            if (cell == nil) {
                cell = [[LHCityItemsTableviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            }
            __weak typeof(self) weakSelf = self;
            if (indexPath.section == 0) {//历史访问
                cell.citys = [self lhCitysWithName:self.visityHistoryArray];
                cell.clickAction = ^(NSInteger index){
                    //Get name
                    NSString * name =[weakSelf visityHistoryArray][index];
                    [LHCityPickerController saveVisityHistory:name];
                    if (weakSelf.selectedAction != nil) {
                        weakSelf.selectedAction(name,self);
                    }
                };
            }else{
                
                cell.citys = [self hotCitysArray];
                cell.clickAction = ^(NSInteger index){
                    LHCity * city =[weakSelf hotCitysArray][index];
                    [LHCityPickerController saveVisityHistory:city.name];
                    if (weakSelf.selectedAction != nil) {
                        weakSelf.selectedAction(city.name,self);
                    }
                };
            }
            return cell;
        }else{
            NSString *reuseID = @"cell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            }
            NSArray * array = [self.citysArray objectAtIndex:indexPath.section - 2];
            LHCity * city = [array objectAtIndex:indexPath.row];
            cell.textLabel.text = city.name;
            return cell;
        }
    }else{
        NSString *reuseID = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        }
        LHCity * city = [self.searchResultCitys objectAtIndex:indexPath.row];
        cell.textLabel.text = city.name;
        return cell;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        NSString * sectionTitle = [self.sectionTitlesArray objectAtIndex:section];
        if (section == 0 || section == 1) {
            sectionTitle = [sectionTitle stringByAppendingString:@"访问"];
        }
        return sectionTitle;
    }else{
        return nil;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView == self.tableView) {
        return self.sectionTitlesArray;
    }else{
        return nil;
    }
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView) {
        return indexPath.section > 1;
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        NSArray * array = [self.citysArray objectAtIndex:indexPath.section - 2];
        LHCity * city = [array objectAtIndex:indexPath.row];
        [LHCityPickerController saveVisityHistory:city.name];
        if (self.selectedAction != nil) {
            self.selectedAction(city.name,self);
        }
    }else{
        LHCity * searchCity = [self.searchResultCitys objectAtIndex:indexPath.row];
        [LHCityPickerController saveVisityHistory:searchCity.name];
        self.selectedAction(searchCity.name,self);
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor blackColor];
    header.textLabel.font = [UIFont boldSystemFontOfSize:14];
    CGRect headerFrame = header.frame;
    header.textLabel.frame = headerFrame;
    header.textLabel.textAlignment = NSTextAlignmentLeft;
    header.contentView.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
}
@end
