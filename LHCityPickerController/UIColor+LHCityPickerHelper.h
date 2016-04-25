//
//  UIColor+LHCityPickerHelper.h
//  LHCityPickerController
//
//  Created by huangwenchen on 16/4/25.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LHCityPickerHelper)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

@end
