//
//  ViewController.m
//  LHCityPickerController
//
//  Created by huangwenchen on 16/4/25.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "ViewController.h"
#import "LHCityPickerController.h"
#import "ExamplePickerController.h"
#import "DianpingPickerController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Present
- (IBAction)clickShow:(id)sender {
    ExamplePickerController * picker = [[ExamplePickerController alloc] init];
    picker.hotCitys = @[@"南京",@"上海",@"背景",@"重庆",@"广州",@"深圳"];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:picker];
    picker.selectedAction = ^(NSString * city,LHCityPickerController * picker){
        NSLog(@"选中城市:%@",city);
        [picker dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:nav animated:YES completion:nil];
}
//Push
- (IBAction)push:(id)sender {
    ExamplePickerController * picker = [[ExamplePickerController alloc] init];
    picker.hotCitys = @[@"南京",@"上海",@"背景",@"重庆",@"广州",@"深圳"];
    picker.selectedAction = ^(NSString * city,LHCityPickerController * picker){
   
        [picker.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:picker animated:YES];
}
//类似大众点评的动画
- (IBAction)dianping:(id)sender {
    DianpingPickerController * picker = [[DianpingPickerController alloc] init];
    picker.hotCitys = @[@"南京",@"上海",@"背景",@"重庆",@"广州",@"深圳"];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:picker];
    
    [self.navigationController addChildViewController:nav];
    [nav didMoveToParentViewController:self];
    [self.navigationController.view addSubview:nav.view];
    nav.view.frame = self.navigationController.view.frame;
    picker.selectedAction = ^(NSString * city,LHCityPickerController * picker){
        NSLog(@"选中城市:%@",city);
        DianpingPickerController * dvc = (DianpingPickerController *)picker;
        [dvc aniamteHide];
    };}

@end
