# LHCityPickerController


###效果截图

<img src="https://raw.github.com/LeoMobileDeveloper/LHCityPickerController/master/ScreenShot/s1.png" width="320" />

###支持

* 所有城市（包括县级市）
* 自定义热门城市
* 城市搜索 
* 快速索引

### 如何使用？
继承`LHCityPickerController`

```
@interface ExamplePickerController : LHCityPickerController

@end
@implementation ExamplePickerController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"城市选择";
    self.navigationController.navigationBar.translucent = NO;
}
@end
```
显示

```
    ExamplePickerController * picker = [[ExamplePickerController alloc] init];
    picker.hotCitys = @[@"南京",@"上海",@"背景",@"重庆",@"广州",@"深圳"];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:picker];
    picker.selectedAction = ^(NSString * city,LHCityPickerController * picker){
        NSLog(@"选中城市:%@",city);
        [picker dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:nav animated:YES completion:nil];
```


TODO

* 定位
