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
- (IBAction)clickShow:(id)sender {
    ExamplePickerController * picker = [[ExamplePickerController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:picker];
    picker.selectedAction = ^(NSString * city,LHCityPickerController * picker){
        NSLog(@"选中城市:%@",city);
        [picker dismissViewControllerAnimated:YES completion:nil];
    };
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
