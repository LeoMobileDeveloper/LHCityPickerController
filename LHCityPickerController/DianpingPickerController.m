//
//  DianpingPickerController.m
//  LHCityPickerController
//
//  Created by huangwenchen on 16/4/27.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "DianpingPickerController.h"

@implementation DianpingPickerController
-(void)dismissSelf{
    [self aniamteHide];
}
-(CGFloat)offsetY{
    return CGRectGetHeight(self.tableView.frame);
}
-(void)aniamteHide{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.searchBar.frame = CGRectOffset(self.searchBar.frame, 0, [self offsetY]);
                         self.tableView.frame = CGRectOffset(self.tableView.frame, 0, [self offsetY]);
                         self.navigationController.navigationBar.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self.navigationController.view removeFromSuperview];
                         [self.navigationController removeFromParentViewController];
                     }];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(dismissSelf)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    self.navigationController.navigationBar.alpha = 0.0;

    self.searchBar.frame = CGRectOffset(self.searchBar.frame, 0, [self offsetY]);
    self.tableView.frame = CGRectOffset(self.tableView.frame, 0, [self offsetY]);
    self.navigationItem.title = @"城市选择";
    self.navigationController.navigationBar.translucent = NO;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.searchBar.frame = CGRectOffset(self.searchBar.frame, 0, -[self offsetY]);
                         self.tableView.frame = CGRectOffset(self.tableView.frame, 0, -[self offsetY]);
                         self.navigationController.navigationBar.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {

                     }];
}
@end
