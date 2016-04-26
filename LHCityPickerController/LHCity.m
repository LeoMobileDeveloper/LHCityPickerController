//
//  LHCity.m
//  LHCityPickerController
//
//  Created by huangwenchen on 16/3/1.
//  Copyright © 2016年 WenchenHuang. All rights reserved.
//

#import "LHCity.h"

@implementation LHCity
-(NSString *)firstCharacter{
    if (self.spell.length != 0) {
        return [[self.spell substringToIndex:1] uppercaseString];
    }
    return nil;
}

+(NSArray *)findCityModelWithCityName:(NSArray *)citynames
                           cityModels:(NSArray *)cityModels
                              isFuzzy:(BOOL)fuzzy{
    if (citynames == nil || cityModels == nil) {
        return nil;
    }
    NSMutableArray * result = [NSMutableArray new];
    for (NSString * toFindName in citynames) {
        for (LHCity * city in cityModels) {//省
            if (fuzzy == false) {//精确查找
                if ([city.name isEqualToString:toFindName]) {
                    [result addObject:city];
                }
            }else{//模糊查找
              //
                NSString * lowerStringToFind = [toFindName lowercaseString];
                if ([city.name rangeOfString:lowerStringToFind].length >0 || [[city.spell lowercaseString] rangeOfString:lowerStringToFind].length > 0) {
                    [result addObject:city];
                }
            }
        }
    }
    return result;
}
+(instancetype)cityWithDictionary:(NSDictionary *)dic{
    LHCity * city = [[LHCity alloc] init];
    city.name = [dic objectForKey:@"name"];
    city.spell = [dic objectForKey:@"spell"];
    return city;
}
@end
