//
//  LHCity.h
//  LHCityPickerController
//
//  Created by huangwenchen on 16/3/1.
//  Copyright © 2016年 WenchenHuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCity : NSObject

@property (strong,nonatomic)NSArray * childrens;

@property (assign,nonatomic)NSUInteger identifier;

@property (assign,nonatomic)NSUInteger pid;

@property (copy,nonatomic)NSString * name;

@property (copy,nonatomic)NSString * spell;

-(NSString *)firstCharacter;

+(NSArray *)findCityModelWithCityName:(NSArray *)citynames cityModels:(NSArray *)cityModels isFuzzy:(BOOL)fuzzy;

+(instancetype)cityWithDictionary:(NSDictionary *)dic;


@end
