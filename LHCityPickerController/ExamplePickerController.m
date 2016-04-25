//
//  ExamplePickerController.m
//  LHCityPickerController
//
//  Created by huangwenchen on 16/4/25.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "ExamplePickerController.h"

@implementation ExamplePickerController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"城市选择";
    self.navigationController.navigationBar.translucent = NO;
}
@end
