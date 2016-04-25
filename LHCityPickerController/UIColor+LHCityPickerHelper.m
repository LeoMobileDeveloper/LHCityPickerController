//
//  UIColor+LHCityPickerHelper.m
//  LHCityPickerController
//
//  Created by huangwenchen on 16/4/25.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "UIColor+LHCityPickerHelper.h"

@implementation UIColor (LHCityPickerHelper)
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}
+ (UIColor *)colorWithHex:(int)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}
@end
